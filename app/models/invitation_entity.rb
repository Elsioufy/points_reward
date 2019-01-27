class InvitationEntity
  def initialize(email, inviter_user)
    @invitation = Invitation.new(email: email, inviter_user: inviter_user)
  end

  def save!
    @invitation.save!
  end
end