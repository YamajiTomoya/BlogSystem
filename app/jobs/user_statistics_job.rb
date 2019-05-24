require_relative '../models/user_statistics_supporter.rb'
class UserStatisticsJob < ApplicationJob
  queue_as :default

  # ユーザー統計情報を収集し、DB、csvファイルに保存
  def perform(id, user, aggregates)
    user_statistic = UserStatistic.find(id)
    # ActiveJobにはシンボルを渡せないので、ここで変換
    aggregates = aggregates.map(&:to_sym)

    supporter = UserStatisticsSupporter.new(user, aggregates)

    # 時間がかかる処理を再現するため10秒眠らせる
    sleep(10)

    data = [] # supporterに渡して書き込むデータ
    aggregates.each do |aggregate|
      # created_atはもともと持っている値を使う
      if aggregate == :created_at
        value = user_statistic.created_at.strftime('%Y-%m-%d %H:%M')
        data.push(value)
        next
      end
      value = supporter.send("calc_#{aggregate}")
      user_statistic[aggregate.to_sym] = value
      data.push(value)
    end

    # csvのパスを作成
    datetime = user_statistic.created_at.strftime('%Y%m%d%H%M%S')
    csv_path = "app/assets/user_csv/#{user.username}_statistics_#{datetime}.csv"

    supporter.generate_csv(csv_path, data)
    user_statistic.update(status: :completed, csv_path: csv_path)
  end
end
