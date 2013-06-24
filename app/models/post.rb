class Post < ActiveRecord::Base
  has_many :votes
  has_many :flags

  validates_presence_of :twitter_handle, :from_user_name
  validates_presence_of :content
  validates_format_of :twitter_handle, with: /\A@\w+\Z/

  attr_accessible :content, :twitter_handle, :tweeted_at, :from_user_name

  def self.sorted(sorted_by = 'tweeted_at DESC')
    order(sorted_by)
  end

  def self.sorted_by_most_votes
    sorted('votes_count DESC')
  end

  def self.ranked
    order("((votes_count - 1) / POW((((DATE_PART('epoch', NOW()) - DATE_PART('epoch', tweeted_at)) / 3600) + 2), 1.8)) DESC, tweeted_at DESC")
  end

  def self.within_past_week
    where('tweeted_at >= ?', (Time.now - 1.week))
  end

  def self.within_past_month
    where('tweeted_at >= ?', (Time.now - 1.month))
  end

  def score
    (votes_count - 1) / (((Time.zone.now - tweeted_at) / 3600) + 2) ** 1.8
  end

  def vote_count
    votes_count
  end

  def age_in_minutes(compare_with = :tweeted_at)
    ((Time.now - self.send(compare_with)) / 60).to_i
  end
end
