class Story < ActiveRecord::Base
  attr_accessible :content, :story_id, :twitter_handle
  validates_presence_of :twitter_handle
  validates_presence_of :content
  #validates_format_of :twitter_handle, with: /A@.*/
end
