class PhotosController < ApplicationController
  def index
    @photos = Photo.ranked.page(params[:page]).limit(48)
  end
end
