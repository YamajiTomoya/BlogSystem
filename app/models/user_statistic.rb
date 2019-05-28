# == Schema Information
#
# Table name: user_statistics
#
#  id                   :bigint           not null, primary key
#  csv_data             :text
#  csv_path             :string
#  start_aggregating_at :datetime
#  status               :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :bigint
#
# Indexes
#
#  index_user_statistics_on_user_id  (user_id)
#

class UserStatistic < ApplicationRecord
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
    self.csv_path = csv_path
  end
end
