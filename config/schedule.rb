require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

every 1.minutes do
  runner "Article.open_reserved_post"
end

every 1.hours do
  runner "Statistic.recollect_data"
end