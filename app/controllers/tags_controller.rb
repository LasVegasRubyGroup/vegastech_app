class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @stories = @tag.stories.within_past_month.ranked.page(params[:page]).limit(50)
  end

end