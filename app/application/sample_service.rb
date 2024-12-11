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

  def update_sample(id:, name:, description:, owner_id:)
    sample = @repository.find_by_id(id)
    raise "Sample not found" if sample.nil?
  
    # Actualizamos los atributos directamente
    sample.name = name
    sample.description = description
    sample.owner_id = owner_id
  
    # Guardamos la muestra actualizada en el repositorio
    @repository.update(id, sample)
  end
  

  def delete_sample(id)
    @repository.delete(id)
  end
end
