source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Especifica la versión de Ruby
ruby "3.3.6"

# Rails framework
gem "rails", "~> 7.0.0"

# PostgreSQL: gema para manejar la base de datos
gem "pg"

# Sinatra: framework web ligero
gem "sinatra"

# Sprockets: gestor del pipeline de activos en Rails
gem "sprockets-rails"

# SQLite3 (para desarrollo o pruebas ligeras)
gem "sqlite3", "~> 1.4"

# Puma: servidor HTTP recomendado para Rails
gem "puma", "~> 5.0"

# Importmap: para importar dependencias JavaScript
gem "importmap-rails"

# Turbo: para actualizar vistas sin recargar la página
gem "turbo-rails"

# Stimulus: framework JavaScript para interactividad ligera
gem "stimulus-rails"

# JBuilder: para construir JSON API
gem "jbuilder"

# Bootsnap: mejora el tiempo de arranque de Rails
gem "bootsnap", require: false

# TZInfo: soporte de zonas horarias para sistemas Windows
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development do
  # Consola interactiva en errores para desarrollo
  gem "web-console"
end

group :development, :test do
  # Herramientas de depuración
  gem "debug", platforms: %i[mri mingw x64_mingw]
end
