# Our User Conroller, used to get users scores, ..etc
class UsersController < ActionController::Base
  require 'csv'
  # GET /users/scores
  # This action is used to get users scores based on import
  def new_import
  end
  # POST /users/import
  # This import list of user names to get their scores
  def import
    user_names = User.import(params[:file].path)
    ur = UserRepository.new(User)
    users = ur.get_users(user_names)
    results = UserPresenter.users_scores_to_hash(users)
    render json: results
  end
end