class UserStatisticsController < ApplicationController
  def index
    user = User.find_by(username: params[:username])
    @statistics = user.user_statistics
  end

  def create
    UserStatisticsJob.perform_later(current_user)
  end

  def download
    user_statistic = UserStatistic.find(params[:id])
    download_file_name = user_statistic.csv_path
    send_file download_file_name
  end
end
