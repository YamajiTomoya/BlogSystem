class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :send_statistic

  protected

  def send_statistic
    @statistic = StatisticDecorator.decorate(Statistic.first)
  end

  # usernamewp用いてログインができるように
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def set_locale
    I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].slice(0, 2)
  end
end
