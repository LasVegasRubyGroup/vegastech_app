class Story < Post
  has_many :comments
  attr_accessible :twitter_id
  validates :twitter_id, :uniqueness => true

  after_create :queue_reply_checker
  after_save :self_love, :promote_tweet

  scope :weekly, -> { where('tweeted_at >= ?', (Time.now - 1.week)) }
  
  scope :within_past_month, -> { where('tweeted_at >= ?', (Time.now - 1.month)) }

  def promote_tweet
    if votes_count == 5
      Twitter.update("RT #{twitter_handle}: #{content}".truncate(140))
    end
  end


  def self.create_from_tweet(tweet)
    #the twitter gem and twetstream gem hashes have different keys
    username = tweet.respond_to?(:from_user) ? tweet.from_user : tweet.user.screen_name
    from_user_name = tweet.respond_to?(:from_user_name) ? tweet.from_user_name : tweet.user.name

    story = self.create(
      twitter_id: tweet.id.to_s,
      twitter_handle: "@#{username}",
      content: tweet.text,
      tweeted_at: tweet.created_at,
      from_user_name: from_user_name)

    media = tweet.respond_to?(:media) ? tweet.media : tweet.entities[:media]
    Photo.create_from_story_and_media(story, media) unless media.blank? || media.empty?

    story
  end

  def self.find_or_create_by_tweet(tweet)
    if story = self.find_by_twitter_id(tweet.id)
      story
    else
      self.create_from_tweet(tweet)
    end
  end

  private

  def self_love
    if id_changed?
      votes.create(twitter_handle: twitter_handle, value: 1)
    end
  end

  def queue_reply_checker
    redis = Redis.new
    redis.set(twitter_id, twitter_id)
    redis.expire(twitter_id, (24*60*60))
    ReplyChecker.perform_in(10.minutes, twitter_id, twitter_id)
  end
end
