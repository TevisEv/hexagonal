# app/application/user_service.rb
class UserService
    def initialize(repository)
      @repository = repository
    end
  
    def authenticate(email, password)
      user = @repository.find_by_email(email)
      return nil unless user # Retorna nil si no encuentra el usuario
      return user if user.password == password # Compara la contraseña
      nil # Retorna nil si la contraseña no coincide
    end
  
    def create_user(first_name:, last_name:, role:, email:, password:, phone:, age:)
      user = User.new(first_name: first_name, last_name: last_name, role: role, email: email, password: password, phone: phone, age: age)
      @repository.save(user)
    end
  
    def list_users
      @repository.all
    end
  
    def delete_user(id)
      @repository.delete(id)
    end
  end
  