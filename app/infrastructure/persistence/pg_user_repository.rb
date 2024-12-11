require 'pg'
require_relative '../../domain/user'

class PgUserRepository
  def initialize(connection)
    @connection = connection
  end

  def save(user)
    result = @connection.exec_params(
      "INSERT INTO users (first_name, last_name, role, email, password, phone, age)
       VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id",
      [user.first_name, user.last_name, user.role, user.email, user.password, user.phone, user.age]
    )
    user.id = result[0]['id'].to_i # Asigna el ID generado al objeto
    user
  end

  def find_by_email(email)
    result = @connection.exec_params("SELECT * FROM users WHERE email = $1 LIMIT 1", [email])
    return nil if result.ntuples.zero?

    row = result[0]
    User.new(
      id: row['id'].to_i,
      first_name: row['first_name'],
      last_name: row['last_name'],
      role: row['role'],
      email: row['email'],
      password: row['password'],
      phone: row['phone'],
      age: row['age'].to_i
    )
  end

  def find_by_id(id)
    result = @connection.exec_params("SELECT * FROM users WHERE id = $1 LIMIT 1", [id])
    return nil if result.ntuples.zero?

    row = result[0]
    User.new(
      id: row['id'].to_i,
      first_name: row['first_name'],
      last_name: row['last_name'],
      role: row['role'],
      email: row['email'],
      password: row['password'],
      phone: row['phone'],
      age: row['age'].to_i
    )
  end

  def all
    result = @connection.exec("SELECT * FROM users")
    result.map do |row|
      User.new(
        id: row['id'].to_i,
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

  def update(user)
    @connection.exec_params(
      "UPDATE users
       SET first_name = $1, last_name = $2, role = $3, email = $4, password = $5, phone = $6, age = $7
       WHERE id = $8",
      [
        user.first_name,
        user.last_name,
        user.role,
        user.email,
        user.password,
        user.phone,
        user.age,
        user.id
      ]
    )
  end

end
