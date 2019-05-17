class CreateStatistics < ActiveRecord::Migration[5.2]
  def change
    create_table :statistics do |t|
      t.integer :user_count
      t.integer :article_count
      t.integer :comment_count
    end
  end
end
