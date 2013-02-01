class InfoController < ApplicationController
  def recent
    @stories = Story.within_past_week.sorted.page(params[:page]).limit(50)
  end

  def users
    @users = User.all
  end

  def best_of_week
    @stories = Story.weekly.sorted_by_most_votes.limit(25)
  end
end
