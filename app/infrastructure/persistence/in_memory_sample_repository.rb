# app/infrastructure/persistence/in_memory_sample_repository.rb
require_relative '../../domain/sample'

class InMemorySampleRepository
  def initialize
    @samples = {}
  end

  def save(sample)
    @samples[sample.id] = sample
  end

  def all
    @samples.values
  end

  def find_by_id(id)
    @samples[id]
  end

  def update(sample)
    @samples[sample.id] = sample
  end

  def delete(id)
    @samples.delete(id)
  end
end
