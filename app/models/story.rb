class Story < Post
  has_many :comments
  attr_accessible :twitter_id
  validates :twitter_id, :uniqueness => true

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

end
