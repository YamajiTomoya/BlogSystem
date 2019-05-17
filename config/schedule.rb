require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, 'log/cron.log'

every 1.minutes do
  runner "Article.check_reservation_post"
end