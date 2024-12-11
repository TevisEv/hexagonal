# app/infrastructure/web/login_controller.rb
require 'sinatra'
require_relative '../../application/user_service'
require_relative '../persistence/pg_user_repository'


# Ruta para mostrar el formulario de login
get '/login' do
  erb :'login/login'
end

# Ruta para procesar el login
post '/login' do
  user = USER_SERVICE.authenticate(params[:email], params[:password])
  if user
    session[:current_user] = { id: user.id, email: user.email, role: user.role }

    case user.role
    when 'admin'
      redirect '/users'
    when 'client'
      redirect '/samples'
    when 'laboratorist'
      redirect '/samples/new'
    else
      @error = "Rol desconocido."
      erb :'login/login'
    end
  else
    @error = "Correo o contraseña incorrectos."
    erb :'login/login'
  end
end
