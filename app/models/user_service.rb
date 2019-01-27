class UserService

  def initialize(user)
    @user = user
    @level = 0
    @eq = 0.5
  end

  def compute_points
    @user = @user.parent
    if @user.present? && (@user.points(category: 'Recommend points') < (1/(1-@eq)))
      @user.add_points(@eq ** @level, category: 'Recommend points')
      @level += 1
      compute_points
    end
  end
end