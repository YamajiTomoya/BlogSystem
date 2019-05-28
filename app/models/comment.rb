# == Schema Information
#
# Table name: comments
#
#  id          :bigint           not null, primary key
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  article_id  :integer
#  articles_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_comments_on_articles_id  (articles_id)
#  index_comments_on_user_id      (user_id)
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :content, presence: true

  def deletable?(current_user)
    return false unless current_user

    current_user.id == user_id || current_user.id == article.user_id
  end

  def posted_by?(current_user)
    return false unless current_user

    current_user.id == user_id
  end
end
