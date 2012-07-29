class Post < ActiveRecord::Base
  attr_accessible :content, :twitter_handle, :tweeted_at
  validates_presence_of :twitter_handle
  validates_presence_of :content
  validates_format_of :twitter_handle, with: /\A@\w+\Z/
  has_many :votes
  has_many :flags

  def rank
    vote_count / age
  end

  def age
    (Time.now - tweeted_at) / 1.days + 1
  end

  #just in case we need to do a counter cachee
  def vote_count
    votes.inject(0) { |sum,v| sum += v.value }
  end

end