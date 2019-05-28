class UserStatisticDecorator < Draper::Decorator
  delegate_all

  # 集計が完了しているかどうかで、表示する時刻を変える
  def show_datetime_status_based
    if object.completed?
      '集計時刻:' + object.start_aggregating_at.strftime('%Y-%m-%d %H:%M:%S')
    else
      '統計取得開始日時:' + object.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
  end
end
