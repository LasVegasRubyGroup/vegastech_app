class StoriesController < ApplicationController
  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.ranked.page(params[:page]).limit(50)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    @story = Story.find(params[:id])
    @comments = @story.comments.order('votes_count desc, created_at desc')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @story }
    end
  end
  
end
