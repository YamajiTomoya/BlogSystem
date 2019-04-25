class AddPasswordConfirmationToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_confirm, :string
  end
end
