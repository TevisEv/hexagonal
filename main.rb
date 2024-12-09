require 'sinatra'
require 'pg'
require 'bundler/setup'

# Configuración de conexión a PostgreSQL
DB_CONNECTION = {
  host: 'db',
  port: 5432,
  dbname: 'rails_app',
  user: 'tevis',
  password: 'secret'
}

# Cargar controladores
require_relative 'app/infrastructure/web/index_controller'
require_relative 'app/infrastructure/web/user_controller'
require_relative 'app/infrastructure/web/sample_controller'
require_relative 'app/infrastructure/web/login_controller'


# Configuración del servidor
set :port, 3000
set :bind, '0.0.0.0'
# Inicia la aplicación
Sinatra::Application.run!
