class Tag < ActiveRecord::Base
  attr_accessible :name, :icon_label

  has_many :taggings
  has_many :stories, through: :taggings

  extend FriendlyId
  friendly_id :name, use: :slugged

end
