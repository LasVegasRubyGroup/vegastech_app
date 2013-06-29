class EventsController < ApplicationController

  def index
    @tag = Tag.find(1)
    @stories = @tag.stories.order('start_time ASC').within_past_month.events_in_the_furture.ranked.page(params[:page]).limit(50)
    @events_per_day = @stories.group_by{ |s| s.start_time.beginning_of_day }

  end

end