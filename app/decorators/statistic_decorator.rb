class StatisticDecorator < Draper::Decorator
  delegate_all

  def updated_at_formatted
    object.updated_at.strftime('%Y-%m-%d %H:%M')
  end
end
