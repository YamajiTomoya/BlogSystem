class AddPostReservationAtToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :post_reservation_at, :datetime
  end
end
