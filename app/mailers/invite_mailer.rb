class InviteMailer < ApplicationMailer
  default from: 'noreply@clark.com'

  def invite_user(invitation)
    @invitation = invitation
    mail(to: @invitation.email, subject: 'New Invitaton to join clark')
  end
end