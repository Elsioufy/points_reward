# Our user repository
class UserRepository
  # Intialize our user model
  def initialize(user_model)
    @model = user_model
  end
  # return user model of specific user name
  def get_user(name)
    @model.find_by(name: name)
  end
end