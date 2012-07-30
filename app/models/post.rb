class Post < ActiveRecord::Base
  has_many :votes
  has_many :flags

  validates_presence_of :twitter_handle
  validates_presence_of :content
  validates_format_of :twitter_handle, with: /\A@\w+\Z/

  attr_accessible :content, :twitter_handle, :tweeted_at

  def self.ranked
    order('(votes_count / tweeted_at) DESC')
  end

  # def age
  #   (Time.now - tweeted_at) / 1.days + 1
  # end

  def vote_count
    votes_count
  end
end
