class Vote < ActiveRecord::Base
  belongs_to :post, counter_cache: true

  validates_uniqueness_of :twitter_handle, scope: :post_id
  validates_presence_of :twitter_handle
  validates_presence_of :post_id
  validates_presence_of :value
  validates_format_of :twitter_handle, with: /\A@\w+\Z/
  validates_inclusion_of :value, in: [-1,1]

  attr_accessible :twitter_handle, :value

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

end
