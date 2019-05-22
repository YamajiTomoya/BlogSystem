class UserStatisticsController < ApplicationController
  def index
    user = User.find_by(username: params[:username])
    @statistics = user.user_statistics.order(id: 'DESC')
    @statistics = UserStatisticDecorator.decorate_collection(@statistics)
  end

  def create
    aggregates = []
    params.each do |key, value|
      aggregates.push(key) if (value == '1') && (key != 'username')
    end
    UserStatisticsJob.perform_later(current_user, aggregates)
    redirect_to(root_path)
  end

  # 作成したユーザー統計のcsvファイルをダウンロード
  def download
    user_statistic = UserStatistic.find(params[:id])
    download_file_name = user_statistic.csv_path
    send_file download_file_name
  end
end
