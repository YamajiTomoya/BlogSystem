require 'csv'

class UserStatisticsData
  attr_reader :data

  def initialize(user, aggregates)
    @user = user
    @aggregates = aggregates
    # 集計開始時刻は必ず含める
    @aggregates.push(:start_aggregating_at)
    @data = {}
    @convert_to_header = {
      article_count: '記事数',
      comment_count: 'コメント数',
      start_aggregating_at: '集計開始時刻'
    }
  end

  # 統計情報を生成
  def generate_data
    @aggregates.each do |aggregate|
      value = send("calc_#{aggregate}")
      @data[aggregate.to_sym] = value
    end
  end

  # csvフォーマットされたデータを生成
  def to_csv
    headers = @aggregates.map { |aggregate| @convert_to_header[aggregate] }
    csv_data = CSV.generate do |csv|
      csv << headers
      csv << @data.values
    end
    csv_data
  end

  # --------集計用関数--------------
  def calc_article_count
    @user.articles.count
  end

  def calc_comment_count
    @user.comments.count
  end

  def calc_start_aggregating_at
    now = Time.zone.now
    return now.strftime('%Y-%m-%d %H:%M:%S')
  end
end
