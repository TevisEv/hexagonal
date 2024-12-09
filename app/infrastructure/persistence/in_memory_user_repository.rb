# app/infrastructure/persistence/in_memory_user_repository.rb
require_relative '../../domain/user'

class InMemoryUserRepository
    def initialize
        @users = {}
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
