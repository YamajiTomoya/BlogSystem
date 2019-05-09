class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  enum status: {open: 10, not_open: 20}

  validates :title, presence: true
  validates :content, presence: true
  validates :status, presence: true
  validates :user_id, presence: true

  def get_comment_num
    return Comment.where(article_id: self.id).size
  end
end