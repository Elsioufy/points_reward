# Invitation entity is used to deal with Invitation model in a more separted single responsbility way
# Fields:
#  email: string
#  inviter_user:  User
class InvitationEntity
  def initialize(email, inviter_user)
    @invitation = Invitation.new(email: email, inviter_user: inviter_user)
  end

  def save!
    @invitation.save!
  end
end