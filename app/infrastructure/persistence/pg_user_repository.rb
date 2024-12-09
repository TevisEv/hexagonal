# app/infrastructure/persistence/pg_user_repository.rb
require 'pg'
require_relative '../../domain/user'

class PgUserRepository
  def initialize(connection)
    @connection = connection
  end

  def find_by_email(email)
    result = @connection.exec_params("SELECT * FROM users WHERE email = $1 LIMIT 1", [email])
    return nil if result.ntuples.zero?

    row = result[0]
    User.new(
      id: row['id'],
      first_name: row['first_name'],
      last_name: row['last_name'],
      role: row['role'],
      email: row['email'],
      password: row['password'],
      phone: row['phone'],
      age: row['age'].to_i
    )
  end


  
    def save(user)
      @connection.exec_params(
        "INSERT INTO users (first_name, last_name, role, email, password, phone, age)
         VALUES ($1, $2, $3, $4, $5, $6, $7)",
        [user.first_name, user.last_name, user.role, user.email, user.password, user.phone, user.age]
      )
    end
  
    def all
      result = @connection.exec("SELECT * FROM users")
      result.map do |row|
        User.new(
          id: row['id'],
          first_name: row['first_name'],
          last_name: row['last_name'],
          role: row['role'],
          email: row['email'],
          password: row['password'],
          phone: row['phone'],
          age: row['age'].to_i
        )
      end
    end
  
    def delete(id)
      @connection.exec_params("DELETE FROM users WHERE id = $1", [id])
    end
  end
  