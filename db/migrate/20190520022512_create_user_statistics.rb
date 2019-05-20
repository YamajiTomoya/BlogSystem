class CreateUserStatistics < ActiveRecord::Migration[5.2]
  def change
    create_table :user_statistics do |t|
      t.references :user
      t.integer :status
      t.integer :article_count
      t.integer :comment_count
      t.string :csv_path
      t.timestamps
    end
  end
end
