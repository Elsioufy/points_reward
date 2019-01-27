class UsersController < ApplicationController
  def scores
    render json: UserPresenter.users_scores_to_hash
  end
end