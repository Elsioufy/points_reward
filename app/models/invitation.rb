# This is used than devise_invitable as devise_invitable does not allow sending multiple invites to same person.
# and if used it updates the invite token thus removing all old invitations which does not cope with the fact
# that we want to accept first invitation sent instead.
# Devise_invitable also has callback issues with observers.
# Invitation class
# Fields:
#  email: string
#  inviter_user:  User
class Invitation < ApplicationRecord
  # validates email to be present and unique, invitations can not be sent twice to the same person, only once.
  # The email at which invitation sent to
  validates :email, presence: true, uniqueness: true
  # validates email to have an email format
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  # The inviter user who initiated the invitation.
  belongs_to :inviter_user, class_name: "User"
  validates :inviter_user, presence: true
  # Validate in case the user invited is already in the system
  validate :user_already_found
  # Delegate name to inviter user
  delegate :name, to: :inviter_user, prefix: true, allow_nil: true
  # Delegate emal to inviter user
  delegate :email, to: :inviter_user, prefix: true, allow_nil: true
  private
    # Checks if user already in the system so we can not invite him back.
    def user_already_found
      if User.find_by(email: self.email).present?
        errors.add(:email, I18n.t('invitation.user_registered'))
        return false
      end
    end
end
