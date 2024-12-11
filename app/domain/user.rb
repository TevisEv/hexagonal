# app/domain/user.rb
class User
  attr_accessor :id # Cambiado a `attr_accessor` para permitir que se asigne después
  attr_reader :first_name, :last_name, :role, :email, :password, :phone, :age

  def initialize(id: nil, first_name:, last_name:, role:, email:, password:, phone:, age:)
    @id = id # Permitimos que sea nil para casos donde el id se genera automáticamente
    @first_name = first_name
    @last_name = last_name
    @role = role
    @password = password
    @phone = phone
    @age = age
    @email = email
  end
end

  