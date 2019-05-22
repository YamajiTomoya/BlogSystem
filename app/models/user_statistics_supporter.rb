require 'csv'

class UserStatisticsSupporter
  def initialize(user, aggregates)
    @user = user
    @aggregates = aggregates

    @user_statistic = user.user_statistics.build
    @user_statistic.status = :making
    @user_statistic.save

    @convert_to_header = {
      article_count: '記事数',
      comment_count: 'コメント数',
      updated_at: '作成日時'
    }
  end

  # ダウンロード用のcsvファイルを作成
  def generate_csv
    headers = @aggregates.map { |aggregate| @convert_to_header[aggregate] }
    data = @aggregates.map { |aggregate| @user_statistic.attributes[aggregate] }

    CSV.open(@user_statistic.csv_path, 'w') do |csv|
      csv << headers
      csv << data
    end
  end

  def set_csv_path
    datetime = @user_statistic.created_at.strftime('%Y%m%d%H%M%S')
    @user_statistic.update(csv_path: "app/assets/user_csv/#{@user.username}_statistics_#{datetime}.csv")
  end

  def set_completed_status
    @user_statistic.update(status: :completed)
  end

  #---------------- 以下統計情報取得用関数 ----------------------

  def calc_article_count
    @user_statistic.update(article_count: @user.articles.count)
  end

  def calc_comment_count
    @user_statistic.update(comment_count: @user.comments.count)
  end

  # updated_atは自動で作成されるが、send(header)で呼べるようにするため
  def calc_updated_at; end
end
