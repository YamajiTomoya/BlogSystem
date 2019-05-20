class UserStatisticsJob < ApplicationJob
  queue_as :default

  def perform(user)
    user_statistic = user.user_statistics.build(status: 'making')
    user_statistic.save

    article_count, comment_count, filepath = user_statistic.generate_csv
    user_statistic.update(article_count: article_count, comment_count: comment_count, status: 'completed', csv_path: filepath)
  end
end
