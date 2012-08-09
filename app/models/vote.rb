class Vote < ActiveRecord::Base
  belongs_to :post, counter_cache: true

  validates_uniqueness_of :twitter_handle, scope: :post_id
  validates_presence_of :twitter_handle
  validates_presence_of :post_id
  validates_presence_of :value
  validates_format_of :twitter_handle, with: /\A@\w+\Z/
  validates_inclusion_of :value, in: [-1,1]

  attr_accessible :twitter_handle, :value, :twitter_id
  attr_accessor :twitter_id

  after_create :queue_reply_checker

  def story
    post
  end

  def comment
    post
  end

  def story=(val)
    post = val
  end

  def comment=(val)
    post = val
  end

  private
  def queue_reply_checker
    return true unless twitter_id.present?
    redis = Redis.new
    redis.set twitter_id, post.twitter_id
    redis.expire twitter_id, (24*60*60)
    ReplyChecker.perform_in(12.minutes,twitter_id,post.twitter_id)
  end

end
