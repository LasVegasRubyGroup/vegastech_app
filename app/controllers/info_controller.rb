class InfoController < ApplicationController

  def recent
    @stories = Story.order('tweeted_at DESC').page(params[:page]).limit(50)
  end

  def users
    @users = User.all
  end

end
