class InvitationObserver < ActiveRecord::Observer
  observe Invitation

  def after_create(invitation)
    InviteMailer.invite_user(invitation).deliver
  end
end