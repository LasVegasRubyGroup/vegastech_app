class Story < ActiveRecord::Base
  attr_accessible :content, :story_id, :twitter_handle
  validates_presence_of :twitter_handle
end
