class Post < ActiveRecord::Base
  has_many :votes
  has_many :flags

  validates_presence_of :twitter_handle
  validates_presence_of :content
  validates_format_of :twitter_handle, with: /\A@\w+\Z/

  attr_accessible :content, :twitter_handle, :tweeted_at

  def self.ranked
    # If you know a better way, please let me know.
    case ActiveRecord::Base.connection.adapter_name
    when 'SQLite'
      order("(votes_count / ((strftime('%s','now') - strftime('%s', tweeted_at)) / 86401)) DESC")
    when 'Mysql2'
      order('(votes_count / ((UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(tweeted_at)) / 86401)) DESC')
    end
  end

  def vote_count
    votes_count
  end
end
