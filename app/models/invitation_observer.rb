# Our Invitation observer, it is used to listen on callback of invitation
class InvitationObserver < ActiveRecord::Observer
  observe Invitation
  # This sends an invite mailer for a successfull invite
  def after_create(invitation)
    InviteMailer.invite_user(invitation).deliver
  end
end