require 'sinatra/activerecord'

configure :development do 
    set :database_file, 'config/database.yml'
end