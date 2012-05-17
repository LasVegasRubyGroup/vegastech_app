class Flag < ActiveRecord::Base

  attr_accessible :story_id, :twitter_handle
  
  belongs_to :story
  validates_presence_of :twitter_handle
  validates_presence_of :story_id
  validates_format_of :twitter_handle, with: /\A@\w+\Z/
  validates_uniqueness_of :twitter_handle, scope: :story_id
  
end
