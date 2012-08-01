class Story < Post
  has_many :comments
  attr_accessible :twitter_id
  validates :twitter_id, :uniqueness => true

  after_save :self_love

  def self.create_from_tweet(tweet)
    #the twitter gem and twetstream gem hashes have different keys 
    username = tweet.respond_to?(:from_user) ? tweet.from_user : tweet.user.screen_name
    from_user_name = tweet.respond_to?(:from_user_name) ? tweet.from_user_name : tweet.name

    self.create!(
      twitter_id: tweet.id.to_s,
      twitter_handle: "@#{username}",
      content: tweet.text,
      tweeted_at: tweet.created_at,
      from_user_name: tweet.from_user_name)
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
end
