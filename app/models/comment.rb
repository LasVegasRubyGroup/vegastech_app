class Comment < Post
  belongs_to :story

  # after_create :queue_reply_checker

  attr_accessible :post_to_twitter, :twitter_profile_image_url
  attr_accessor :post_to_twitter

  private

  def queue_reply_checker
    unless twitter_id.present?
      redis = Redis.new
      redis.set(twitter_id, story.twitter_id)
      redis.expire(twitter_id, (24*60*60))
      ReplyChecker.perform_in(10.minutes, twitter_id, story.twitter_id)
    end
  end
end
