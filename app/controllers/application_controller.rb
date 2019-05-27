class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :send_statistic

  protected

  def set_locale
    I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].slice(0, 2)
  end

  def send_statistic
    @statistic = StatisticDecorator.decorate(Statistic.first)
  end
end
