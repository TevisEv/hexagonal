class Sample
  attr_accessor :id
  attr_reader :name, :description, :owner_id, :created_by, :created_at

  def initialize(id: nil, name:, description:, owner_id:, created_by: nil, created_at: Time.now)
    @id = id
    @name = name
    @description = description
    @owner_id = owner_id
    @created_by = created_by
    @created_at = created_at
  end
end
