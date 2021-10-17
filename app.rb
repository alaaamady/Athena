require 'sinatra'
require_relative 'models/notes.rb'

class NotesApp < Sinatra::Base 

get '/' do
  @title = 'Sign Up'
  erb :signup, :layout => :layout
end

get '/signin' do
  @title = 'Sign In'
  erb :signin
end

post '/signup' do
  @title = 'Notes'
  @notes = Note.all
  erb :notes
end

post '/signin' do
  @title = 'Notes'
  @notes = Note.all
  erb :notes
end


get '/notes' do
  @notes = Note.all
  @title = 'All Notes'
  erb :notes
end

post '/notes' do
  @notes = Note.all
  n = Note.create(params[:notes])
  n.title = params[:title]
  n.content = params[:content]
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

end
