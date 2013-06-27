class StoriesController < ApplicationController
  def index
    @stories = Story.within_past_month.ranked.page(params[:page]).limit(50)
  end

  def show
    @story = Story.find(params[:id])
    @comments = @story.comments.order('votes_count desc, created_at')
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])

    if @story.update_attributes(params[:story])
      redirect_to root_url, notice: 'Tags have been updated.'
    else
      render :edit
    end
  end
end
