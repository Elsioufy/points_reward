# User Service class, contain methods that deals with entities (users)
class UserService
  # class instance variables
  # Initialize a user service
  # user [Entity/Model]
  # Default level number 0
  def initialize(user)
    @user = user
    @level = 0
    # Category is used to categorize points under a specific static name
    @category = 'Recommend points'
    # This is the main equation at which computes the scores per user
    @eq = 0.5
  end
  # Computes the points of the inviters given the invitee joined.
  def compute_points
    @user = @user.parent
    # checks if the parent user is present
    # This is a geometric series, total points will never exceed (2) in this case per each user
    # We should stop when we reach total points of 2
    if @user.present? && (@user.points(category: @category) < (1/(1-@eq)))
      @user.add_points(@eq ** @level, category: @category)
      @level += 1
      compute_points
    end
  end
  # This disconnects children of a user and reconnect them to the user parent
  # This function is helpful when a user gets destroyed so that the scores reward continue
  def update_users_tree
    if @user.parent.present?
      @user.children.update_all(parent_id: @user.parent_id)
    end
  end

  # This method gets scores based on actions/rules uploaded
  def self.compute_get_scores(sorted_actions)
    @users = []
    sorted_actions_data = sorted_actions[:data]
    user_repository = UserRepository.new(User)
    sorted_actions_data.each do |action_hash|
      self.send("#{action_hash[:action]}_user",user_repository, action_hash[:from_user], action_hash[:to_user])
    end
    @users = @users.uniq.reject(&:blank?)
    UserPresenter.users_scores_to_hash(@users)
  end
  private
    # Inviters a user service, takes:
    # user_repositry: UserRepository model at which we can get the user model from name
    # from_name:  string
    # to_name: string
    def self.invite_user(user_repository, from_name, to_name)
      from_user = user_repository.get_user(from_name)
      if from_user.blank?
        # Bypass email validation by creating email from name.
        email = "clark.#{from_name.downcase}clark@clark.com"
        from_user_ent = UserEntity.new(from_name, email, (Faker::Internet.password 8,10))
        from_user_ent.save!
        from_user = from_user_ent.get_user
      end
      to_user = user_repository.get_user(to_name)
      if to_user.blank?
        email = "clark.#{to_name.downcase}clark@clark.com"
        invitation = InvitationEntity.new(email, from_user)
        begin
          invitation.save!
        rescue ActiveRecord::RecordInvalid => invalid
        end
      end
      @users << from_user
    end

    # Inviters a user service, takes:
    # user_repositry: UserRepository model at which we can get the user model from name
    # from_name:  string
    # to_name: string (mostly nil) since accepts, accept from single user on single invitation in the system.
    def self.accepts_user(user_repository, from_name, to_name=nil)
      from_user = user_repository.get_user(from_name)
      if from_user.blank?
        email = "clark.#{from_name.downcase}clark@clark.com"
        from_user_ent = UserEntity.new(from_name, email, (Faker::Internet.password 8,10))
        from_user_ent.save!
        from_user = from_user_ent.get_user
        @users << from_user.parent
      end
    end
end