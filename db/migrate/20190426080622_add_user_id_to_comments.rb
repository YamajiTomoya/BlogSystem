class AddUserIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :user, index: true
    add_reference :comments, :articles, index: true
  end
end
