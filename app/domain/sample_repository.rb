# app/domain/sample_repository.rb
class SampleRepository
  def save(sample)
    raise NotImplementedError
  end

  def find_by_owner_id(owner_id)
    raise NotImplementedError
  end

  def find_by_id(id)
    # Implementa lógica para encontrar una muestra por ID
    raise NotImplementedError
  end

  def update(id, updated_sample)
    # Implementa lógica para actualizar la muestra en la base de datos
    raise NotImplementedError
  end
end
