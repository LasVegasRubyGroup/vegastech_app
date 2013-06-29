class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @stories = @tag.stories.within_past_month.events_in_the_furture.ranked.page(params[:page]).limit(50)
  end

end