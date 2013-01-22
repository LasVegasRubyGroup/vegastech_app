require 'sidekiq'

class ReplyChecker
  include Sidekiq::Worker
  sidekiq_options :timeout => 10.minutes

  def perform(tweet_id, original_id)
    original_tweet = Post.find_by_twitter_id(original_id)
    comments = TwitterReplyFinder.new.check_replies(tweet_id, original_id)

    redis = Redis.new
    if redis.exists(tweet_id)
      unless comments.empty?
        original_tweet.touch
        redis.expire(tweet_id, (24*60*60))
      end

      interval = (original_tweet.age_in_minutes(:updated_at) * 5).minutes
      interval = 1 if interval < 1
      ReplyChecker.perform_in(interval, tweet_id, original_id)
    end
  end
end
