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

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
