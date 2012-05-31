class SessionsController < ApplicationController
  def create
    user = User.find_by_uid(auth_hash['uid'])
    unless user
      user = User.create(twitter_handle: twitter_handle, uid: auth_hash['uid'])
    end
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end

  def twitter_handle
    "@" + auth_hash['info']['nickname']
  end
end
