require 'sinatra'
require_relative 'models/notes.rb'
require_relative 'models/users.rb'

class NotesApp < Sinatra::Base 

configure do
    enable :sessions unless test?
    set :session_secret, "secret"
end

get '/' do
  @title = 'Sign Up'
  erb :signup, :layout => :layout
end

get '/signin' do
  @title = 'Sign In'
  erb :signin
end

get '/archive' do
  @notes = Note.where(archived: true, users_id: session[:user_id])
  @title = 'Archive'
  erb :archive
end

post '/signup' do
  @title = 'Notes'
  @user = User.new(params[:user])
  @user.password = params[:password]
  @user.save!
  session[:user_id] = @user.id
  redirect '/notes'
end

post '/signin' do
  @title = 'Sign In'
  @user = User.find_by_email(params[:user][:email])
  if @user.password == params[:password]
    session[:user_id] = @user.id
    redirect '/notes'
  else
    redirect '/'
  end
end

get '/logout' do
  session.clear
  redirect'/'
end 


get '/notes' do
  @notes = Note.where(archived: false, users_id: session[:user_id])
  @title = 'All Notes'
  @user = User.find_by_id(session[:user_id])
  erb :notes
end

post '/notes' do
  @notes = Note.where(users_id: session[:user_id])
  n = Note.create(params[:note])
  n.users_id = session[:user_id]
  n.save
  redirect '/notes'
end

get '/notes/:id' do 
  @note = Note.find params[:id]
  @title = "Edit note ##{params[:id]}"
  erb :edit
end

post '/notes/:id' do
  n = Note.find params[:id]
  n.content = params[:content]
  n.save
  redirect '/notes'
end

get '/notes/delete/:id' do 
  n = Note.find params[:id]
  n.destroy
  redirect '/notes'
end

get '/archive/:id' do
  n = Note.find params[:id]
  n.archived = true
  n.save
  redirect '/archive'
end

get '/notes/unarchive/:id' do
  n = Note.find params[:id]
  n.archived = false
  n.save
  redirect '/notes'
end

end
