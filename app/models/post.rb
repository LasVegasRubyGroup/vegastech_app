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
      # Nasty because SQLite does not have a ^ operator.
      age_calculation = "((strftime('%s','now') - strftime('%s', tweeted_at)) / 60 / 60)"
      order("(votes_count - 1) / (#{age_calculation} + 2) * #{age_calculation} * (#{age_calculation} * 0.8) DESC")
    when 'Mysql2'
      order("(votes_count - 1) / (((UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(tweeted_at)) / 60 / 60) + 2) ^ 1.8) DESC")
    end
  end

  def score
    (votes_count - 1) / ((Time.now - tweeted_at).hours) ** 1.8
  end

  def vote_count
    votes_count
  end
end
