class TweetScraper
  def self.get_latest
    Twitter.search("#{ENV['TRACK_HASHTAG']} -rt", rpp: 100).results.each do |tweet|
      Story.create_from_tweet(tweet)
    end
  end
end
