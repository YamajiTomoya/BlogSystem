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

  def comment_num
    Comment.where(article_id: id).size
  end

  def author?(current_user)
    if current_user.nil?
      false
    else
      current_user.id == user_id
    end
  end

  def accessible?(current_user)
    open? || author?(current_user)
  end
end
