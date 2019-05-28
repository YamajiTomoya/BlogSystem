require_relative '../models/user_statistics_data.rb'
class UserStatisticsJob < ApplicationJob
  queue_as :default

  # ユーザー統計情報を収集し、DB、csvファイルに保存
  def perform(us_id, user, aggregates)
    us = UserStatistic.find(us_id)

    # ActiveJobにはシンボルを渡せないので、ここで変換
    aggregates = aggregates.map(&:to_sym)
    us_data = UserStatisticsData.new(user, aggregates)

    # 時間がかかる処理を再現するため10秒眠らせる
    sleep(10)

    # 統計情報を生成、用いて更新
    us_data.generate_data
    us.update(us_data.data)

    # csv_dataを更新、保存時にcsvファイル作成が走る
    us.csv_data = us_data.to_csv
    us.update(status: :completed)
  end
end
