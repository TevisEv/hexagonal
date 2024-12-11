require 'sinatra'
require_relative '../../application/user_service'
require_relative '../persistence/in_memory_user_repository'

# Inicialización del repositorio y servicio
repository = InMemoryUserRepository.new
user_service = UserService.new(repository)

enable :method_override # Habilita métodos PUT y DELETE

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
  @user = USER_SERVICE.find_user_by_id(params[:id])
  if @user
    erb :'user/edit'
  else
    status 404
    "User not found"
  end
end

# Ruta para procesar la actualización del usuario
put '/users/:id' do
  USER_SERVICE.update_user(
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
delete '/users/:id' do
  user = USER_SERVICE.find_user_by_id(params[:id])
  if user
    USER_SERVICE.delete_user(params[:id])
    redirect '/users', 303
  else
    status 404
    "User not found"
  end
end
