# Our User Conroller, used to get users scores, ..etc
class UsersController < ApplicationController
  # GET /users/scores
  # This action is used to get users scores based on import
  def new_import
  end
  # POST /users/import
  # This import list of user names to get their scores
  def import
    results = User.get_scores(params[:file].path)
    if results.has_key?(:errors)
      render json: results, status: -1
    else
      render json: results, status: 0
    end
  end
end