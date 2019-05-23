class UserStatisticsController < ApplicationController
  before_action :authenticate_user!, only: %i[index create download]
  before_action :ensure_current_user, only: %i[index create download]

  def index
    @statistics = current_user.user_statistics.order(id: 'DESC')
    @statistics = UserStatisticDecorator.decorate_collection(@statistics)
  end

  def create
    @user_statistic = current_user.user_statistics.build
    @user_statistic.status = :making
    @user_statistic.save

    aggregates = []
    params.each do |key, value|
      aggregates.push(key) if (value == '1') && (key != 'username')
    end

    UserStatisticsJob.perform_later(@user_statistic.id, current_user, aggregates)

    # 更新すると同じ処理が繰り返されてしまうため、そうした誤りが起きないようにリダイレクトさせる
    redirect_to(user_statistics_path)
  end

  # 作成したユーザー統計のcsvファイルをダウンロード
  def download
    user_statistic = UserStatistic.find(params[:id])
    download_file_name = user_statistic.csv_path
    send_file download_file_name
  end

  # 統計情報ページにアクセスできるのは本人のみ
  def ensure_current_user
    unless current_user.username == params[:username]
      redirect_to(root_path, alert: (I18n.t 'You_do_not_have_the_authority'))
    end
  end
end
