class RssController < ApplicationController
  layout false

  def index
    @count = params[:count]
    @stories = Story.ranked.where("votes_count >= #{@count.to_i}").limit(100)
  end
end
