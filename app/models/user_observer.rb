class UserObserver < ActiveRecord::Observer
  observe User

  def before_create(user)
    inv_repo = InvitationRepository.new(Invitation)
    invitation = inv_repo.get_invitation(user)
    user.parent_id = invitation.inviter_user_id if invitation.present?
  end

  def after_create(user)
    user_service = UserService.new(user)
    user_service.compute_points
  end
end