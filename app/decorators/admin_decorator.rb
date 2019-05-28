class AdminDecorator < Draper::Decorator
  delegate_all

  def created_at_formatted
    object.created_at.strftime('%Y-%m-%d %H:%M')
  end
end
