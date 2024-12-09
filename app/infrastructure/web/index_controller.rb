# app/infrastructure/web/index_controller.rb
require 'sinatra'

get '/' do
  erb :index
end
