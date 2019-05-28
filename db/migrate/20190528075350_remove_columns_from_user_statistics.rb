class RemoveColumnsFromUserStatistics < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_statistics, :article_count, :integer
    remove_column :user_statistics, :comment_count, :integer
  end
end
