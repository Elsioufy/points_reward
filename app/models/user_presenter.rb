# User presenter class, it prepares our entities to be presented cleanly
class UserPresenter
  # Return hash scores per each user given users sent.
  def self.users_scores_to_hash(users)
    results = {}
    users.each do |user|
      results[user.name] = user.points(category: @category)
    end
    return results
  end
end