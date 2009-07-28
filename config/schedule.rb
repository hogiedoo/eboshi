set :cron_log, "log/whenever.log"

every 5.minutes do
  rake "eboshi:cache_blog_feed"
end
