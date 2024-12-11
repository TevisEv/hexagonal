# app/infrastructure/web/sample_controller.rb
require 'sinatra'
require_relative '../../application/sample_service'
require_relative '../../application/user_service'
require_relative '../persistence/in_memory_sample_repository'
require_relative '../persistence/in_memory_user_repository'

# Inicialización de repositorios y servicios
sample_repository = InMemorySampleRepository.new
user_repository = InMemoryUserRepository.new

sample_service = SampleService.new(sample_repository)
user_service = UserService.new(user_repository)

# Ruta para listar las muestras
get '/samples' do
  @samples = sample_service.list_samples
  erb :'sample/list'
end

# Ruta para mostrar el formulario de creación de muestras
get '/samples/new' do
  @users = user_service.list_users.select { |user| user.role == 'client' } # Filtrar solo clientes
  @current_user = session[:current_user] # El laboratorista logueado
  erb :'sample/new'
end

# Ruta para crear una nueva muestra
post '/samples' do
  laboratorist_email = session[:current_user][:email] # Tomar el correo del laboratorista logueado
  sample_service.create_sample(
    name: params[:name],
    description: params[:description],
    owner_id: params[:owner_id],
    created_by: laboratorist_email
  )
  redirect '/samples'
end

# Ruta para eliminar una muestra
delete '/samples/:id' do
  sample = sample_service.find_sample_by_id(params[:id])
  if sample
    sample_service.delete_sample(params[:id])
    redirect '/samples', 303
  else
    status 404
    "Sample not found"
  end
end
