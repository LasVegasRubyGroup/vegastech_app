class TweetScraper
  def self.get_latest
    Twitter.search("#{ENV['TRACK_HASHTAG']} -rt", rpp: 100).results.each do |tweet|
      begin
        story = Story.find_or_create_by_tweet(tweet)
        print '.'

        Twitter.retweets(story.twitter_id).each do |retweet|
          story.votes.create(twitter_handle: "@#{retweet.from_user}", value: 1)
          print 'r'
        end
      rescue Exception => e
        print 'x'
      end
    end
  end
end
