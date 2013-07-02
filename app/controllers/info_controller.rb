class InfoController < ApplicationController
  def recent
    @stories = Story.within_past_week.sorted.page(params[:page]).limit(25)
  end

  def users
    @users = User.all
  end

  def best_of_week
    @stories = Story.within_past_week.sorted_by_most_votes.limit(25)
  end

  def about

  end
end
