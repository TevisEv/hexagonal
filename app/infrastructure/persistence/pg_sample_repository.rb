require 'pg'
require_relative '../../domain/sample'

class PgSampleRepository
  def initialize(connection)
    @connection = connection
  end

  def save(sample)
    result = @connection.exec_params(
      "INSERT INTO samples (name, description, owner_id, created_by, created_at)
       VALUES ($1, $2, $3, $4, DEFAULT) RETURNING id, created_at",
      [sample.name, sample.description, sample.owner_id, sample.created_by]
    )
    row = result[0]
    Sample.new(
      id: row['id'].to_i,
      name: sample.name,
      description: sample.description,
      owner_id: sample.owner_id,
      created_by: sample.created_by,
      created_at: row['created_at']
    )
  end

  def all
    result = @connection.exec("SELECT * FROM samples")
    result.map do |row|
      Sample.new(
        id: row['id'].to_i,
        name: row['name'],
        description: row['description'],
        owner_id: row['owner_id'].to_i,
        created_by: row['created_by'].to_i,
        created_at: Time.parse(row['created_at'])
      )
    end
  end

  def find_by_id(id)
    result = @connection.exec_params("SELECT * FROM samples WHERE id = $1 LIMIT 1", [id])
    return nil if result.ntuples.zero?

    row = result[0]
    Sample.new(
      id: row['id'].to_i,
      name: row['name'],
      description: row['description'],
      owner_id: row['owner_id'].to_i,
      created_by: row['created_by'].to_i,
      created_at: Time.parse(row['created_at'])
    )
  end

  def update(id, sample)
    @connection.exec_params(
      "UPDATE samples
       SET name = $1, description = $2, owner_id = $3
       WHERE id = $4",
      [sample.name, sample.description, sample.owner_id, id]
    )
  end

  def delete(id)
    @connection.exec_params("DELETE FROM samples WHERE id = $1", [id])
  end
end
