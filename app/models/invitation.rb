class Invitation < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  belongs_to :inviter_user, class_name: "User"
  validate :user_already_found
  private
    def user_already_found
      if User.find_by(email: self.email).present?
        errors.add(:email, 'User already registered')
        return false
      end
    end
end
