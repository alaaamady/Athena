require 'sinatra'

get '/' do
  erb :signup, :layout => :layout
end

get '/signin' do
  erb :signin
end

post '/signup' do
  erb :notes
end

post '/signin' do
  erb :notes
end