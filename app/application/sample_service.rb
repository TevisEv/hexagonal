class SampleService
    def initialize(repository)
      @repository = repository
    end
  
    def create_sample(name:, description:, owner_id:, created_by:)
      sample = Sample.new(name: name, description: description, owner_id: owner_id, created_by: created_by)
      @repository.save(sample)
    end
  
    def list_samples
      @repository.all
    end
  
    def delete_sample(id)
      @repository.delete(id)
    end
  end
  
  