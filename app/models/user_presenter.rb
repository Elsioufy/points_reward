class UserPresenter

  def self.users_scores_to_hash
    users = User.all
    results = {}
    users.each do |user|
      results[user.name] = user.points(category: @category)
    end
    return results
  end

end