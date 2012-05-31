class Post < ActiveRecord::Base
  attr_accessible :content, :twitter_handle
  validates_presence_of :twitter_handle
  validates_presence_of :content
  validates_format_of :twitter_handle, with: /\A@\w+\Z/
  has_many :votes
  has_many :flags

  def rank
    votes.inject(0) { |sum,v| sum += v.value }
  end

end
