Faker::Config.locale = :en
USER_NUM = 10
(1..USER_NUM).each do |i|
  User.seed do |s|
    s.id = i
    fake_username = Faker::Name.first_name
    s.username = fake_username
    s.email = "#{fake_username}@gmail.com"
    s.password = 'xxxxxxxxxx'
  end
end
