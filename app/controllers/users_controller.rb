# Our User Conroller, used to get users scores, ..etc
class UsersController < ApplicationController
  require 'csv'
  # GET /users/scores
  # This action is used to get users scores based on import
  def new_import
  end
  # POST /users/import
  # This import list of user names to get their scores
  def import
    results = User.get_scores(params[:file].path)
    render json: results
  end
end