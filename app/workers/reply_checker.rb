class ReplyChecker
  include Sidekiq::Worker

  def perform(tweet_id, original_id)
    comments_added = TwitterReplyFinder.new.check_replies(tweet_id, original_id)
    redis = Redis.new
    if redis.exists tweet_id
      if comments_added > 0
        redis.expire tweet_id, (24*60*60)
      end
      ReplyChecker.perform_in(12.minutes,tweet_id,original_id)
    end
  end

end
