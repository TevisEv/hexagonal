# main.rb
require 'sinatra'
require_relative 'app/infrastructure/persistence/pg_user_repository'
require_relative 'app/application/user_service'
require_relative 'app/infrastructure/persistence/pg_sample_repository'
require_relative 'app/application/sample_service'

DB_CONNECTION = PG.connect(
  host: 'db',  # Cambia a 'localhost' si no usas Docker
  port: 5432,
  dbname: 'rails_app',
  user: 'tevis',
  password: 'secret'
)
SAMPLE_REPOSITORY = PgSampleRepository.new(DB_CONNECTION)
SAMPLE_SERVICE = SampleService.new(SAMPLE_REPOSITORY)

USER_REPOSITORY = PgUserRepository.new(DB_CONNECTION)
USER_SERVICE = UserService.new(USER_REPOSITORY)

enable :sessions
enable :method_override # Habilita métodos HTTP como PUT y DELETE
# Requiere otros controladores
require_relative 'app/infrastructure/web/login_controller'
require_relative 'app/infrastructure/web/user_controller'
require_relative 'app/infrastructure/web/sample_controller'
require_relative 'app/infrastructure/web/index_controller'
set :port, 3000
set :bind, '0.0.0.0'
# Arranca la aplicación
Sinatra::Application.run! if __FILE__ == $PROGRAM_NAME
