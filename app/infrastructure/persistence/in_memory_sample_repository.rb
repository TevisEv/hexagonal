# app/infrastructure/persistence/in_memory_sample_repository.rb
require_relative '../../domain/sample'

class InMemorySampleRepository
  def initialize
    @samples = []
    @next_id = 1
  end

  def save(sample)
    sample.id ||= @next_id
    @next_id += 1
    @samples << sample
    sample
  end

  def all
    @samples
  end

  def find_by_id(id)
    @samples.find { |sample| sample.id == id }
  end

  def delete(id)
    @samples.reject! { |sample| sample.id == id }
  end
end

