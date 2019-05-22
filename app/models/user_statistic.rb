# == Schema Information
#
# Table name: user_statistics
#
#  id            :bigint           not null, primary key
#  user_id       :bigint
#  status        :integer
#  article_count :integer
#  comment_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class UserStatistic < ApplicationRecord
  belongs_to :user
  enum status: { completed: 10, making: 20 }
end
