module ArticlesHelper
  def page_owner_display(user)
    return "#{user.username}のページ" unless current_user

    user.id == current_user.id ? 'My page' : "#{user.username}のページ"
  end

  def shrink_content(content)
    content.size <= 150 ? content : content.slice(0, 150) + '...'
  end
end
