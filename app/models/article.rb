# == Schema Information
#
# Table name: articles
#
#  id                  :bigint           not null, primary key
#  title               :string
#  content             :string
#  status              :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#  post_reservation_at :datetime
#

class Article < ApplicationRecord
  ransacker :created_at do
    Arel.sql('date(created_at)')
  end

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  enum status: { open: 10, not_open: 20 }

  validates :title, presence: true
  validates :content, presence: true
  validates :status, presence: true
  validates :user_id, presence: true

  def write_by?(user)
    if user.nil?
      false
    else
      user.id == user_id
    end
  end

  def accessible?(current_user)
    open? || write_by?(current_user)
  end

  # 予約時間になった投稿を公開
  def self.open_reserved_post
    now = Time.zone.now
    con = ActiveRecord::Base.connection
    query = "SELECT * FROM articles WHERE ('#{now}' >= post_reservation_at);"
    articles = Article.find_by_sql(query)

    articles.each do |article|
      article.status = :open
      article.post_reservation_at = nil
      article.save
    end
  end
end
