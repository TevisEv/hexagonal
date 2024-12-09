# app/domain/user_repository.rb
class UserRepository
    def save(user)
      raise NotImplementedError
    end
  
    def find_by_email(email)
      raise NotImplementedError
    end
  
    def find_by_role(role)
      raise NotImplementedError
    end
  end
  