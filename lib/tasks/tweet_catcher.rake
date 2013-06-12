require 'dotenv/tasks'

namespace :vegastech do
  desc "Fetch tweets from twitter for ##{ENV['TRACK_HASHTAG']}"
  task tweet_catcher: :dotenv do
    TweetScraper.get_latest
  end
end
