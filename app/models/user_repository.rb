# Our user repository
class UserRepository
  def initialize(user_model)
    @model = user_model
  end
  # Gets the invitation of a specific user
  def get_users(user_names)
    @model.where(name: user_names).order(:name)
  end
end