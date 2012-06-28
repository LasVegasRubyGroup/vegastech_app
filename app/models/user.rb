class User < ActiveRecord::Base
  attr_accessible :twitter_handle, :uid

  def up_vote(story) 
    story.votes.create(twitter_handle: twitter_handle, value: 1)
  end

  def voted_on?(story)
    story.votes.exists?(twitter_handle: twitter_handle)
  end

  def admin?
    false
  end 
end
