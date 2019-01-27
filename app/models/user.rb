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
  require 'reward_text_parser'
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  # Making sure the name is present and unique, this is important for the webservice call
  # to get users statstics on scores
  validates :name, presence: true, uniqueness: true
  has_many :invitations, foreign_key: "inviter_user_id", dependent: :destroy
  # Self reference model
  belongs_to :parent, class_name: 'User', optional: true
  has_many :children, class_name: 'User', foreign_key: 'parent_id'

  def self.get_scores(file_path)
    sorted_actions = RewardTextParser.import(file_path)
    if sorted_actions.has_key?(:errors)
      sorted_actions
    else
      UserService.compute_get_scores(sorted_actions)
    end
  end
  protected
    # Ignore confirmation.
    def confirmation_required?
      return false
      # !%w(development test staging product).include? Rails.env
    end
end
