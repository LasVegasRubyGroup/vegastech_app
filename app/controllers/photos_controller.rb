class PhotosController < ApplicationController
  def index
    @photos = Photo.within_past_month.ranked.page(params[:page]).limit(48)
  end
end
