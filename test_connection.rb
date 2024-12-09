require 'pg'

begin
  # Configuración de conexión
  conn = PG.connect(
    host: 'db', # Cambiar según tu configuración
    port: 5432, # Cambiar si usas otro puerto
    dbname: 'rails_app', # Nombre de tu base de datos
    user: 'tevis', # Usuario de tu base de datos
    password: 'secret' # Contraseña de tu base de datos
  )

  puts "Conexión exitosa a PostgreSQL"

  # Realizar una consulta
  result = conn.exec("SELECT * FROM users;")

  if result.ntuples.zero?
    puts "La tabla 'users' está vacía o no existe."
  else
    puts "Datos en la tabla 'users':"
    result.each do |row|
      puts "ID: #{row['id']}, Nombre: #{row['first_name']}, Correo: #{row['email']}, Rol: #{row['role']}"
    end
  end

  conn.close
rescue PG::Error => e
  puts "Error al conectar a PostgreSQL: #{e.message}"
end
