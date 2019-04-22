class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :content
      t.boolean :open_flg, default: false
      t.string :author
      t.timestamps
    end
  end
end
