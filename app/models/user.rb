# User class
# Fields:
#  email: string
#  name: string
#  password: string
#  parent: self reference User
#  other devise attributes
#  merit attributes
class User < ApplicationRecord
  # This is used to compute score points for the inviters, each user has it
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  # Making sure the name is present and unique, this is important for the webservice call
  # to get users statstics on scores
  validates :name, presence: true, uniqueness: true
  has_many :invitations, foreign_key: "inviter_user_id", dependent: :destroy
  belongs_to :parent, class_name: 'User', optional: true
  has_many :children, class_name: 'User', foreign_key: 'parent_id'
  protected
    # Ignore confirmation in case our environment is in development or testing.
    def confirmation_required?
      !%w(development test).include? Rails.env
    end
end
