require 'csv'

class UserStatisticsSupporter
  def initialize(user, aggregates)
    @user = user
    @aggregates = aggregates

    @convert_to_header = {
      article_count: '記事数',
      comment_count: 'コメント数',
      created_at: '作成日時'
    }
  end

  # ダウンロード用のcsvファイルを作成
  def generate_csv(csv_path, data)
    headers = @aggregates.map { |aggregate| @convert_to_header[aggregate] }
    CSV.open(csv_path, 'w') do |csv|
      csv << headers
      csv << data
    end
  end

  #---------------- 以下統計情報取得用関数 ----------------------

  def calc_article_count
    @user.articles.count
  end

  def calc_comment_count
    @user.comments.count
  end
end
