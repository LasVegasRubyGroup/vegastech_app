class Comment < Post
  belongs_to :story
  after_create :queue_reply_checker

  private
  def queue_reply_checker
    unless twitter_id.present?
      redis = Redis.new
      redis.set twitter_id, story.twitter_id
      redis.expire twitter_id, (24*60*60)
      ReplyChecker.perform_in(12.minutes,twitter_id,story.twitter_id)
    end
  end

end
