# app/application/user_service.rb
class UserService
    def initialize(repository)
      @repository = repository
    end
  # Autenticar al usuario por correo y contraseña
    def authenticate(email, password)
        @repository.all.find do |user|
        user.email == email && user.password == password
        end
    end
  
    def create_user(id:, first_name:, last_name:, role:, email:, password:, phone:, age:)
      user = User.new(id: id, first_name: first_name, last_name: last_name, role: role, email: email, password: password, phone: phone, age: age)
      @repository.save(user)
    end
  
    def list_users
      @repository.all
    end
  
    def find_user_by_id(id)
      @repository.find_by_id(id)
    end
  
    def update_user(user)
      @repository.update(user)
    end
  
    def delete_user(id)
      @repository.delete(id)
    end
  end
  