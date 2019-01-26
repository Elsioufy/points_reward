class InvitationRepository
  def initialize(invitation_model)
    @model = invitation_model
  end

  def is_invited?(user)
    @model.find_by(email: user.email).present?
  end

  def get_invitation(user)
    @model.find_by(email: user.email)
  end
end