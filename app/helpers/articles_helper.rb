module ArticlesHelper
  # 自分のページか他人のページかで、ページ上部の文字を変える
  def page_owner_display(user)
    return "#{user.username}のページ" unless current_user

    user.id == current_user.id ? 'My page' : "#{user.username}のページ"
  end
end
