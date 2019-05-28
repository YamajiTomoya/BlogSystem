class AddStartAggregatingAtToUserStatistics < ActiveRecord::Migration[5.2]
  def change
    add_column :user_statistics, :start_aggregating_at, :datetime
  end
end
