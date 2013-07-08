class Story < Post
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  validates :twitter_id, :uniqueness => true

  # after_create :queue_reply_checker
  after_save :self_love #:promote_tweet

  attr_accessible :twitter_id, :twitter_profile_image_url, :tag_ids, :start_time

  def self.events_in_the_furture
    # where('start_time IS NOT NULL AND start_time > ?', Time.zone.now )
    where('start_time > ?', Time.zone.now )
  end

  def self.find_or_create_by_meetup_id(json_event)
    if story = self.find_by_twitter_id("meetup_#{json_event['id']}")
      story
    else
      self.create_from_meetup(json_event)
    end
  end


  def self.create_from_meetup(json_event)
    start_time_milliseconds = json_event['time'].to_i
    story = self.find_or_create_by_twitter_id(
      twitter_id: "meetup_#{json_event['id']}",
      twitter_handle: '@VegasTech_News',
      content: MeetupFetcher.meetup_story_content(json_event),
      tweeted_at: Time.current,
      from_user_name: 'Meetup API',
      start_time: Time.at(start_time_milliseconds / 1000),
      twitter_profile_image_url: 'https://si0.twimg.com/profile_images/3117763267/78f3399ac23aa91c2697a4887380191b_normal.png'
      )

    Tagging.create(story_id: story.id, tag_id: 1)
    
  end

  def self.create_from_tweet(tweet)
    story = self.create(
      twitter_id: tweet.id.to_s,
      twitter_handle: "@#{tweet.user.screen_name}",
      twitter_profile_image_url: tweet.user.profile_image_url,
      content: tweet.text,
      tweeted_at: tweet.created_at,
      from_user_name: tweet.user.name)

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

  def promote_tweet
    if votes_count == 5
      Twitter.update("RT #{twitter_handle}: #{content}".truncate(140))
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
