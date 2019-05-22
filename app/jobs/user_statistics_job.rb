require_relative '../models/user_statistics_supporter.rb'
class UserStatisticsJob < ApplicationJob
  queue_as :default

  # ユーザー統計情報を収集し、DB、csvファイルに保存
  def perform(user, aggregates)
    # ActiveJobにはシンボルを渡せないので、ここで変換
    aggregates = aggregates.map(&:to_sym)

    user_statistic = UserStatisticsSupporter.new(user, aggregates)

    aggregates.each do |aggregate|
      user_statistic.send("calc_#{aggregate}")
    end

    user_statistic.set_csv_path
    user_statistic.generate_csv
    user_statistic.set_completed_status
  end
end
