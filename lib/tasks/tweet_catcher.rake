
namespace :vegastech do
  desc "Fetch tweets from twitter for #VegasTech every 10 minutes (as of 2012-06-13)"
  task :tweet_catcher => :environment do
    TweetScraper.get_latest
  end
end
