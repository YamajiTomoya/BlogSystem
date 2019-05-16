ARTICLE_NUM = 30
(1..ARTICLE_NUM).each do |i|
  Article.seed do |s|
    s.id = i
    s.title = Faker::Book.title
    s.content = Faker::Lorem.sentence(random_words_to_add = 30)
    s.user = User.find(rand(USER_NUM) + 1)
  end
end
