module ArticlesHelper
  def page_owner_display(user)
    return "#{user.username}のページ" unless current_user

    user.id == current_user.id ? 'My page' : "#{user.username}のページ"
  end
end
