# User Observer class listens to callbacks for users, this provides more single responsibility.
class UserObserver < ActiveRecord::Observer
  observe User
  # Sets the parent id of a user in case this user was invited by him.
  def before_create(user)
    inv_repo = InvitationRepository.new(Invitation)
    invitation = inv_repo.get_invitation(user)
    user.parent_id = invitation.inviter_user_id if invitation.present?
  end

  # This computes the total points for the all inviters after a new user gets created in the system.
  def after_create(user)
    user_service = UserService.new(user)
    user_service.compute_points
  end
  # Updates the invites tree when a user gets deleted.
  def before_destroy(user)
    user_service = UserService.new(user)
    user_service.update_users_tree
  end
end