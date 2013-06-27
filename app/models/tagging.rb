class Tagging < ActiveRecord::Base
  attr_accessible :story_id, :tag_id

  belongs_to :story
  belongs_to :tag
end
