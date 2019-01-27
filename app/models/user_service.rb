# User Service class, contain methods that deals with entities (users)
class UserService
  # class instance variables
  # Category is used to categorize points under a specific static name
  @category = 'Recommend points'
  # This is the main equation at which computes the scores per user
  @eq = 0.5
  # Initialize a user service
  # user [Entity/Model]
  # Default level number 0
  def initialize(user)
    @user = user
    @level = 0
  end
  # Computes the points of the inviters given the invitee joined.
  def compute_points
    @user = @user.parent
    # checks if the parent user is present
    # This is a geometric series, total points will never exceed (2) in this case per each user
    # We should stop when we reach total points of 2
    if @user.present? && (@user.points(category: @category) < (1/(1-@eq)))
      @user.add_points(@eq ** @level, category: @category)
      @level += 1
      compute_points
    end
  end
  # This disconnects children of a user and reconnect them to the user parent
  # This function is helpful when a user gets destroyed so that the scores reward continue
  def update_users_tree
    if @user.parent.present?
      @user.children.update_all(parent_id: @user.parent_id)
    end
  end
end