# == Schema Information
#
# Table name: comments
#
#  id          :bigint           not null, primary key
#  content     :string
#  article_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#  articles_id :bigint
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
