# app/application/user_service.rb
class UserService
  def initialize(repository)
    @repository = repository
  end

  def authenticate(email, password)
    user = @repository.find_by_email(email)
    return nil unless user
    return user if user.password == password
    nil
  end

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
    @repository.save(user) # La base de datos se encarga de asignar el id
  end


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
  
  def list_users
    @repository.all
  end
  def find_user_by_id(id)
    @repository.find_by_id(id)
  end
  def delete_user(id)
    @repository.delete(id)
  end
end

