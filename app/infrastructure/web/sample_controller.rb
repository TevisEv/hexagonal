require 'sinatra'
require_relative '../../application/sample_service'
require_relative '../../application/user_service'

# Usar servicios ya inicializados en main.rb
sample_service = SAMPLE_SERVICE
user_service = USER_SERVICE

enable :method_override # Habilita métodos PUT y DELETE

# Ruta para listar las muestras
get '/samples' do
  @samples = sample_service.list_samples.map do |sample|
    client = user_service.find_user_by_id(sample.owner_id)
    laboratorist = user_service.find_user_by_id(sample.created_by)
    OpenStruct.new(
      id: sample.id,
      name: sample.name,
      description: sample.description,
      owner_email: client&.email || 'Desconocido',
      created_by_email: laboratorist&.email || 'Desconocido'
    )
  end
  erb :'sample/list'
end

# Ruta para mostrar el formulario de creación de muestras
get '/samples/new' do
  @clients = user_service.list_clients
  if session[:current_user].nil?
    redirect '/login'
  end
  @current_user = session[:current_user]
  erb :'sample/new'
end

# Ruta para crear una nueva muestra
post '/samples' do
  if session[:current_user].nil?
    redirect '/login'
  end
  laboratorist_id = session[:current_user][:id]
  sample_service.create_sample(
    name: params[:name],
    description: params[:description],
    owner_id: params[:owner_id].to_i,
    created_by: laboratorist_id
  )
  redirect '/samples'
end

# Ruta para mostrar el formulario de edición de una muestra
get '/samples/:id/edit' do
  @sample = sample_service.find_sample_by_id(params[:id].to_i)
  if @sample.nil?
    halt 404, 'Muestra no encontrada'
  end

  @clients = user_service.list_clients
  if session[:current_user].nil?
    redirect '/login'
  end
  @current_user = session[:current_user]
  erb :'sample/edit'
end

# Ruta para actualizar una muestra
put '/samples/:id' do
  if session[:current_user].nil?
    redirect '/login'
  end

  sample = sample_service.find_sample_by_id(params[:id].to_i)
  if sample.nil?
    halt 404, 'Muestra no encontrada'
  end

  sample_service.update_sample(
    id: params[:id].to_i,
    name: params[:name],
    description: params[:description],
    owner_id: params[:owner_id].to_i
  )
  redirect '/samples'
end

# Ruta para eliminar una muestra
delete '/samples/:id' do
  sample_service.delete_sample(params[:id].to_i)
  redirect '/samples'
end
