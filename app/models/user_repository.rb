# Our user repository
class UserRepository
  def initialize(user_model)
    @model = user_model
  end
  # Gets the invitation of a specific user
  def get_users(names)
    @model.where(name: names).order(:name)
  end

  def get_user(name)
    @model.find_by(name: name)
  end
end