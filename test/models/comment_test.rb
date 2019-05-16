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

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
