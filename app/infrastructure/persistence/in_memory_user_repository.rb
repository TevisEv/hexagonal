# app/infrastructure/persistence/in_memory_user_repository.rb
require_relative '../../domain/user'

class InMemoryUserRepository
    def initialize
        @users = {
          "1" => User.new(id: "1", first_name: "Admin", last_name: "User", role: "admin", email: "admin@example.com", password: "admin123", phone: "123456789", age: 30),
          "2" => User.new(id: "2", first_name: "Client", last_name: "User", role: "client", email: "client@example.com", password: "client123", phone: "987654321", age: 25),
          "3" => User.new(id: "3", first_name: "Lab", last_name: "User", role: "laboratorist", email: "lab@example.com", password: "lab123", phone: "456789123", age: 35)
        }
      end

  def save(user)
    @users[user.id] = user
  end

  def all
    @users.values
  end

  def find_by_id(id)
    @users[id]
  end

  def update(user)
    @users[user.id] = user
  end

  def delete(id)
    @users.delete(id)
  end
end
