class ChangePointsType < ActiveRecord::Migration[5.2]
  def up
    change_column :merit_score_points, :num_points, :decimal, precision: 9, scale: 4
  end

  def down
    change_column :merit_score_points, :num_points, :integer
  end
end
