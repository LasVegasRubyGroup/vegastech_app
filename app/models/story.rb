class Story < Post
  has_many :comments
  attr_accessible :twitter_id
  validates :twitter_id, :uniqueness => true

  after_save :self_love

  def self.ranked
    Story.all.sort do |a,b| 
      r = b.rank <=> a.rank
      if r == 0
        b.tweeted_at <=> a.tweeted_at
      else
        r
      end
    end
  end

  def self.create_from_tweet(tweet)
    self.create!(
      twitter_id: tweet.id.to_s,
      twitter_handle: "@#{tweet.user.screen_name}",
      content: tweet.text,
      tweeted_at: tweet.created_at)
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
