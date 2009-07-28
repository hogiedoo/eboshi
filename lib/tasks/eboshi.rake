namespace :eboshi do
  desc "Fetches eboshi blog feed and caches it locally."
  task :cache_blog_feed do
    require 'open-uri'
    feed_url = "http://eboshi-app.blogspot.com/feeds/posts/default"
    atom = open(feed_url, 'User-Agent' => 'Ruby-Wget').read
    File.open "db/blog_feed.atom", "w" do |f|
      f.write atom
    end
  end
end
