class ChangeToArticlesForRelationship < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :user_id, :integer
    remove_column :articles, :author, :string
  end
end
