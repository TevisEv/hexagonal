# app/domain/user.rb
class User
    attr_reader :id, :first_name, :last_name, :role, :email, :password, :phone, :age
  
    def initialize(id:, first_name:, last_name:, role:, email:, password:, phone:, age:)
      @id = id
      @first_name = first_name
      @last_name = last_name
      @role = role # admin, client, laboratorist
      @password = password
      @phone = phone
      @age = age
      @email = email
    end
  end
  