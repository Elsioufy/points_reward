class Invitation < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  belongs_to :inviter_user, class_name: "User"

end
