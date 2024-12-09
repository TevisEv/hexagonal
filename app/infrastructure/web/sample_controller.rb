# app/infrastructure/web/sample_controller.rb
require 'sinatra'
require_relative '../../application/sample_service'
require_relative '../persistence/in_memory_sample_repository'

repository = InMemorySampleRepository.new
sample_service = SampleService.new(repository)

get '/samples' do
  @samples = sample_service.list_samples
  erb :'samples/list'
end

post '/samples' do
  sample_service.create_sample(params)
  redirect '/samples'
end

# Más rutas CRUD...
