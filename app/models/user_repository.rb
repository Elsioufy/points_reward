# Our user repository
class UserRepository
  # Intialize our user model
  def initialize(user_model)
    @model = user_model
  end
  # return collection of users given their names
  def get_users(names)
    @model.where(name: names).order(:name)
  end
  # return user model of specific user name
  def get_user(name)
    @model.find_by(name: name)
  end
end