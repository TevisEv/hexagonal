# app/infrastructure/web/user_controller.rb
require 'sinatra'
require_relative '../../application/user_service'
require_relative '../persistence/in_memory_user_repository'

repository = InMemoryUserRepository.new
user_service = UserService.new(repository)

get '/users' do
  @users = user_service.list_users
  erb :'user/list'
end

post '/users' do
  user_service.create_user(params)
  redirect '/users'
end

# Más rutas CRUD...
