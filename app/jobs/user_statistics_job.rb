require_relative '../models/user_statistics_supporter.rb'
class UserStatisticsJob < ApplicationJob
  queue_as :default

  # ユーザー統計情報を収集し、DB、csvファイルに保存
  def perform(id, user, aggregates)
    # ActiveJobにはシンボルを渡せないので、ここで変換
    aggregates = aggregates.map(&:to_sym)
    user_statistic = UserStatisticsSupporter.new(id, user, aggregates)

    # 時間がかかる処理を再現するため10秒眠らせる
    sleep(10)

    aggregates.each do |aggregate|
      user_statistic.send("calc_#{aggregate}")
    end

    user_statistic.set_csv_path
    user_statistic.generate_csv
    user_statistic.set_completed_status
  end
end
