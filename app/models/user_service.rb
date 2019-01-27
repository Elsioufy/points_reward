class UserService

  def initialize(user)
    @user = user
    @level = 0
    @eq = 0.5
    @category = 'Recommend points'
  end

  def compute_points
    @user = @user.parent
    if @user.present? && (@user.points(category: @category) < (1/(1-@eq)))
      @user.add_points(@eq ** @level, category: @category)
      @level += 1
      compute_points
    end
  end

  def update_users_tree
    if @user.parent.present?
      @user.children.update_all(parent_id: @user.parent_id)
    end
  end
end