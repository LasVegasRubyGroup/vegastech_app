class InfoController < ApplicationController
  def recent
    @stories = Story.sorted.page(params[:page]).limit(50)
  end

  def users
    @users = User.all
  end

  def best_of_week
    @stories = Story.weekly.sorted('votes_count DESC').limit(25)
  end
end
