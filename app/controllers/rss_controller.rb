class RssController < ApplicationController
  layout false

  def index
    @count = params[:count]
    @stories = Story.ranked.where("votes_count >= #{@count.to_i}").limit(100)

    respond_to do |f|
      f.rss { render(layout: false) }
    end
  end
end
