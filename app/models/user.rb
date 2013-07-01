class User < ActiveRecord::Base
  attr_accessible :twitter_handle, :uid, :auth_credentials, :twitter_profile_image_url

  def index
  end

  def up_vote(story)
    story.votes.create(twitter_handle: twitter_handle, value: 1)
  end

  def voted_on?(story)
    story.votes.exists?(twitter_handle: twitter_handle)
  end

  def admin?
    ENV['ADMIN_HANDLES'].split(',').include?(twitter_handle.gsub(/^@/, ''))
  end

  def twitter_client
    Twitter::Client.new(
      oauth_token: auth_credentials.split(':').first,
      oauth_token_secret: auth_credentials.split(':').second)
  end
end
