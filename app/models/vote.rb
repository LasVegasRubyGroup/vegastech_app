class Vote < ActiveRecord::Base
  attr_accessible :story_id, :twitter_handle, :value
  validates_presence_of :twitter_handle
  validates_presence_of :story_id
  validates_presence_of :value
  validates_format_of :twitter_handle, with: /\A@\w+\Z/
  validates_inclusion_of :value, in: [-1,1]
  belongs_to :story
  validates_uniqueness_of :twitter_handle, scope: :story_id
end
