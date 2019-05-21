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

require 'csv'
class UserStatistic< ApplicationRecord
  belongs_to :user
  enum status: {completed: 10, making: 20 }

  # ダウンロード用のcsvファイルを作成、途中で得た情報を返す
  def generate_csv
    user = User.find(self.user_id)
    username = user.username
    article_count = user.articles.count
    comment_count = user.comments.count

    f_datetime = self.created_at.strftime('%Y%m%d%H%M%S')
    d_datetime = self.created_at.strftime('%Y-%m-%d %H:%M')

    filepath = "app/assets/user_csv/#{username}_statistics_#{f_datetime}.csv"
    headers = ['記事数', 'コメント数', '作成日時']
    data = [article_count, comment_count, d_datetime]
    CSV.open(filepath, 'w') do |csv|
      csv << headers
      csv << data
    end

    return article_count, comment_count, filepath
  end
end
