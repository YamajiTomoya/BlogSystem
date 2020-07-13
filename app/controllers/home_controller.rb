class HomeController < ApplicationController
  # ここからログインの有無によってユーザーページかログインページか振り分け*
  def allocate
    if current_user
      redirect_to(user_page_path(current_user.username))
    else
      redirect_to(new_user_session_path)
    end
  end
end
