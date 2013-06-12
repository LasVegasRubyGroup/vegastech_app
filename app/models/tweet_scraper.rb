class TweetScraper
  def self.get_latest
    Twitter.search("##{ENV['TRACK_HASHTAG']} -rt", :count => 100).results.each do |tweet|
      begin
        story = Story.find_or_create_by_tweet(tweet)
        print '.'

        Twitter.retweets(story.twitter_id).each do |retweet|
          story.votes.create(twitter_handle: "@#{retweet.from_user}", value: 1, twitter_id: retweet.id.to_s)
          print 'r'
        end
      rescue Twitter::Error::TooManyRequests
        sleep 5
      rescue Exception => e
        print 'x'
      end
    end
  end
end
