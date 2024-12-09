# app/application/sample_service.rb
class SampleService
    def initialize(repository)
      @repository = repository
    end
  
    def create_sample(id:, name:, description:, owner_id:, created_by:)
      sample = Sample.new(id: id, name: name, description: description, owner_id: owner_id, created_by: created_by)
      @repository.save(sample)
    end
  
    def list_samples
      @repository.all
    end
  
    def find_sample_by_id(id)
      @repository.find_by_id(id)
    end
  
    def update_sample(sample)
      @repository.update(sample)
    end
  
    def delete_sample(id)
      @repository.delete(id)
    end


  end
  