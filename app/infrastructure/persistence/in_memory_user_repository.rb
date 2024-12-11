require_relative '../../domain/user'

class InMemoryUserRepository
  def initialize
    @users = {}
    @next_id = 1
  end

  def save(user)
    user.id ||= @next_id
    @next_id += 1
    @users[user.id] = user
  end

  def all
    @users.values
  end

  def find_by_id(id)
    @users[id]
  end

  def find_by_email(email)
    @users.values.find { |user| user.email == email }
  end

  def update(user)
    @users[user.id] = user
  end

  def delete(id)
    @users.delete(id)
  end
end
