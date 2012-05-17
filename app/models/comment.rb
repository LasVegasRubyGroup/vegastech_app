class Comment < ActiveRecord::Base
  attr_accessible :content, :story_id, :twitter_handle
  belongs_to :story
  
end
