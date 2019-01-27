class UserEntity

  def initialize(name, email, password)
    @user = User.new(name: name, email: email, password: password)
  end

  def save!
    @user.save!
  end

  def get_user
    @user
  end
end