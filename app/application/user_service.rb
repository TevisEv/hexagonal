require 'twilio-ruby'

class UserService
  def initialize(repository)
    @repository = repository
    @twilio_client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  # Autenticación del usuario
  def authenticate(email, password)
    user = @repository.find_by_email(email)
    return nil unless user
    return user if user.password == password
    nil
  end

  # Crear un usuario y enviar notificación de WhatsApp
  def create_user(first_name:, last_name:, role:, email:, password:, phone:, age:)
    user = User.new(
      first_name: first_name,
      last_name: last_name,
      role: role,
      email: email,
      password: password,
      phone: phone,
      age: age
    )
    @repository.save(user) # Guardar usuario en la base de datos

    # Enviar notificación de WhatsApp
    send_whatsapp_notification(phone, "Bienvenido #{first_name} a nuestra aplicación. Tu usuario ha sido creado exitosamente.")
  rescue => e
    puts "Error creando el usuario: #{e.message}"
  end

  # Actualizar un usuario existente
  def update_user(id:, first_name:, last_name:, role:, email:, password:, phone:, age:)
    user = @repository.find_by_id(id)
    return unless user

    updated_user = User.new(
      id: user.id,
      first_name: first_name || user.first_name,
      last_name: last_name || user.last_name,
      role: role || user.role,
      email: email || user.email,
      password: password || user.password,
      phone: phone || user.phone,
      age: age || user.age
    )

    @repository.update(updated_user)
  end

  # Listar todos los usuarios
  def list_users
    @repository.all
  end

  # Listar solo los clientes
  def list_clients
    @repository.all.select { |user| user.role == 'client' }
  end

  # Buscar usuario por ID
  def find_user_by_id(id)
    @repository.find_by_id(id)
  end

  # Eliminar un usuario
  def delete_user(id)
    @repository.delete(id)
  end

  private

  # Método privado para enviar una notificación de WhatsApp
  def send_whatsapp_notification(phone, message)
    from = 'whatsapp:+14155238886' # Número de WhatsApp habilitado en Twilio
    to = "whatsapp:#{phone}"      # Número de WhatsApp del usuario

    @twilio_client.messages.create(
      from: from,
      to: to,
      body: message
    )
    puts "Mensaje de WhatsApp enviado exitosamente a #{phone}."
  rescue Twilio::REST::RestError => e
    puts "Error enviando mensaje de WhatsApp: #{e.message}"
  end
end
