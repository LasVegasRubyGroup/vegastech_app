class TagsController < ApplicationController
  before_filter :ensure_admin, only: [:index]

  def index
    @tags = Tag.order('name ASC')
  end

  def show
    @tag = Tag.find(params[:id])
    @stories = @tag.stories.within_past_month.ranked.page(params[:page]).limit(50)

    #make sure the newest freinly_id is being used
    if request.path != tag_path(@tag)
      redirect_to tag_path(@tag), status: :moved_permanently
    end
  end

private

  def ensure_admin
    if current_user.nil? || !current_user.admin?
      redirect_to root_url
    end
  end

end