class ArticleDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime('%Y-%m-%d %H:%M')
  end

  def updated_at
    object.updated_at.strftime('%Y-%m-%d %H:%M')
  end

  def post_reservation_at
    object.post_reservation_at.strftime('%Y-%m-%d %H:%M') unless object.post_reservation_at.nil?
  end

  # 一覧ページに収まり切らないような長い文章は、途中で区切る
  def content
    object.content.size <= 150 ? object.content : object.content.slice(0, 150) + '...'
  end
end
