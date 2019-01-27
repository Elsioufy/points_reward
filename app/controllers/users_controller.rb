# Our User Conroller, used to get users scores, ..etc
class UsersController < ApplicationController
  # GET /users/scores
  # This action is used to get users scores
  def scores
    render json: UserPresenter.users_scores_to_hash
  end
end