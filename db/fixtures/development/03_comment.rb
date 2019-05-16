COMMENT_NUM = 50
(1..COMMENT_NUM).each do |i|
  Comment.seed do |s|
    s.id = i
    s.content = Faker::Lorem.sentence(random_words_to_add = 10)
    s.user = User.find(rand(USER_NUM) + 1)
    s.article = Article.find(rand(ARTICLE_NUM) + 1)
  end
end
