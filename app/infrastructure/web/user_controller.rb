# app/infrastructure/web/user_controller.rb
require 'sinatra'
require_relative '../../application/user_service'
require_relative '../persistence/in_memory_user_repository'

# Inicialización del repositorio y servicio
repository = InMemoryUserRepository.new
user_service = UserService.new(repository)

# Ruta para mostrar el formulario de creación de usuarios
get '/users/new' do
    erb :'user/new'
  end
  
  # Ruta para listar usuarios
  get '/users' do
    @users = USER_SERVICE.list_users
    erb :'user/list'
  end
  
  # Ruta para crear un nuevo usuario
  post '/users' do
    USER_SERVICE.create_user(
      first_name: params[:first_name],
      last_name: params[:last_name],
      role: params[:role],
      email: params[:email],
      password: params[:password],
      phone: params[:phone],
      age: params[:age]
    )
    redirect '/users'
  end
# Ruta para mostrar el formulario de edición
get '/users/:id/edit' do
  @user = user_service.find_user_by_id(params[:id])
  erb :'user/edit'
end

# Ruta para procesar la actualización del usuario
post '/users/:id' do
  user_service.update_user(
    id: params[:id],
    first_name: params[:first_name],
    last_name: params[:last_name],
    role: params[:role],
    email: params[:email],
    password: params[:password],
    phone: params[:phone],
    age: params[:age]
  )
  redirect '/users'
end

# Ruta para eliminar un usuario
post '/users/:id/delete' do
  user_service.delete_user(params[:id])
  redirect '/users'
end
