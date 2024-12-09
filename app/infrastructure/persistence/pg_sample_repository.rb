require_relative '../../domain/sample'

class PgSampleRepository
  def initialize(connection)
    @connection = connection
  end

  def save(sample)
    @connection.exec_params(
      "INSERT INTO samples (name, description, owner_id, created_by)
       VALUES ($1, $2, $3, $4)",
      [sample.name, sample.description, sample.owner_id, sample.created_by]
    )
  end

  def all
    result = @connection.exec("SELECT * FROM samples")
    result.map do |row|
      Sample.new(
        id: row['id'],
        name: row['name'],
        description: row['description'],
        owner_id: row['owner_id'],
        created_by: row['created_by'],
        created_at: row['created_at']
      )
    end
  end

  def find_by_id(id)
    result = @connection.exec_params("SELECT * FROM samples WHERE id = $1", [id])
    return nil if result.ntuples.zero?

    row = result[0]
    Sample.new(
      id: row['id'],
      name: row['name'],
      description: row['description'],
      owner_id: row['owner_id'],
      created_by: row['created_by'],
      created_at: row['created_at']
    )
  end

  def delete(id)
    @connection.exec_params("DELETE FROM samples WHERE id = $1", [id])
  end
end
