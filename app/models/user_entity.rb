# User entity is used to deal with User model in a more separted single responsbility way
# Fields:
#  name: string
#  email: string

class UserEntity

  def initialize(name, email, password)
    @user = User.new(name: name, email: email, password: password)
  end

  def save!
    @user.save!
  end
  # Gets the user model of an entity
  def get_user
    @user
  end
end