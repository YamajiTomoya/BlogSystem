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

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
