class User < ApplicationRecord
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :invitations, foreign_key: "inviter_user_id", dependent: :destroy
  belongs_to :parent, class_name: 'User', optional: true
  has_many :children, class_name: 'User', foreign_key: 'parent_id'
  protected
    def confirmation_required?
      !%w(development test).include? Rails.env
    end
end
