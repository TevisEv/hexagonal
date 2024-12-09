# app/domain/sample.rb
class Sample
    attr_reader :id, :name, :description, :owner_id, :created_by, :created_at
  
    def initialize(id:, name:, description:, owner_id:, created_by:, created_at: Time.now)
      @id = id
      @name = name
      @description = description
      @owner_id = owner_id
      @created_by = created_by # laboratorist who created it
      @created_at = created_at
    end
  end
  