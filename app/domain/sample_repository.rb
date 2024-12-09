# app/domain/sample_repository.rb
class SampleRepository
    def save(sample)
      raise NotImplementedError
    end
  
    def find_by_owner_id(owner_id)
      raise NotImplementedError
    end
  end
  