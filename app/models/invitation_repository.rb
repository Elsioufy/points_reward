# Our invitation repository, contain methods that deals with user entities
class InvitationRepository
  def initialize(invitation_model)
    @model = invitation_model
  end
  # Gets the invitation of a specific user
  def get_invitation(user)
    @model.find_by(email: user.email)
  end
end