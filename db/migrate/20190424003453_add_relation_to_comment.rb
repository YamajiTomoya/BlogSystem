class AddRelationToComment < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :user_id, :integer
    remove_column :comments, :article_id, :integer
    add_reference :comments, :user, foreign_key: true
    add_reference :comments, :article, foreign_key: true
  end
end
