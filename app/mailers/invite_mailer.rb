class InviteMailer < ApplicationMailer
  default from: 'noreply@points_reward.com'

  def invite_user(invitation)
    @invitation = invitation
    mail(to: @invitation.email, subject: 'New Invitaton to join Points Reward')
  end
end