class StoriesController < ApplicationController
  def index
    @stories = Story.within_past_month.ranked.page(params[:page]).limit(50)
  end

  def show
    @story = Story.find(params[:id])
    @comments = @story.comments.order('votes_count desc, created_at')
  end
end
