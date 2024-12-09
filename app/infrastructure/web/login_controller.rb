# app/infrastructure/web/login_controller.rb
require 'sinatra'
require_relative '../../application/user_service'
require_relative '../persistence/in_memory_user_repository'

# Inicializa el repositorio y servicio
repository = InMemoryUserRepository.new
user_service = UserService.new(repository)

# Ruta para mostrar el formulario de login
get '/login' do
  erb :'login/login'
end

# Ruta para manejar el login
post '/login' do
  user = user_service.authenticate(params[:email], params[:password])

  if user
    case user.role
    when 'admin'
      redirect '/users'
    when 'client'
      redirect '/samples'
    when 'laboratorist'
      redirect '/samples'
    else
      @error = "Rol desconocido."
      erb :'login/login'
    end
  else
    @error = "Credenciales inválidas."
    erb :'login/login'
  end
end
