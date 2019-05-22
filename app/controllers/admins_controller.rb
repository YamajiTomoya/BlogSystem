class AdminsController < ApplicationController
  def index
    # 非ログインならログインページに飛ばす
    redirect_to(new_admin_session_path) unless current_admin

    @users = AdminDecorator.decorate_collection(User.all.order(:id))
  end
end
