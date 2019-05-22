class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :send_statistic
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :logout_admin

  protected

  def set_locale
    I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].slice(0, 2)
  end

  def send_statistic
    @statistic = StatisticDecorator.decorate(Statistic.first)
  end

  # usernameを用いてログインができるように
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def after_sign_in_path_for(resource)
    case resource
    when User
      root_path
    when Admin
      admin_path
    end
  end

  # 管理者ページから離れたらadminをログアウトさせる
  def logout_admin
    if ((controller_name == 'admins') && (action_name == 'index')) || \
       ((controller_name == 'sessions') && (action_name == 'create'))
      return
    end

    sign_out current_admin if current_admin
  end
end
