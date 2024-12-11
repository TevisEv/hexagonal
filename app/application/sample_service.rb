# app/application/sample_service.rb
class SampleService
  def initialize(repository)
    @repository = repository
  end

  def create_sample(name:, description:, owner_id:, created_by:)
    raise "El campo 'created_by' es obligatorio." if created_by.nil?

    sample = Sample.new(
      name: name,
      description: description,
      owner_id: owner_id,
      created_by: created_by
    )
    @repository.save(sample)
  end

  def list_samples
    @repository.all
  end

  def find_sample_by_id(id)
    @repository.find_by_id(id)
  end

  def delete_sample(id)
    @repository.delete(id)
  end
end
