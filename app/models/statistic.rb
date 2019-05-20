# == Schema Information
#
# Table name: statistics
#
#  id            :bigint           not null, primary key
#  user_count    :integer
#  article_count :integer
#  comment_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Statistic < ApplicationRecord
  def self.update
    if Statistic.all.size.zero?
      statistic = Statistic.new
      statistic.save
    end
    statistic = Statistic.first
    user_count = User.all.size
    article_count = Article.all.size
    comment_count = Comment.all.size
    statistic.update(user_count: user_count, article_count: article_count, comment_count: comment_count)
  end
end
