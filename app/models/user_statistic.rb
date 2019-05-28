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
  attr_accessor :csv_data
  before_save :save_csv_file
  belongs_to :user
  enum status: { completed: 10, making: 20 }

  protected

  # csv_dataがセットされている状態でsaveされるとcsvファイルを作成
  def save_csv_file
    return unless csv_data

    # csvのパスを作成
    username = user.username
    datetime = start_aggregating_at.strftime('%Y%m%d%H%M%S')
    csv_path = "app/assets/user_csv/#{username}_statistics_#{datetime}.csv"

    File.open(csv_path, 'w') do |f|
      f.puts(csv_data)
    end

    # レコードの更新
    self.csv_data = nil
    self.csv_path = csv_path
  end
end
