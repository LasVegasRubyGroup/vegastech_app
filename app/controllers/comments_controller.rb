class CommentsController < ApplicationController
  def create
    @story = Story.find(params[:story_id])
    @comment = @story.comments.build(
      params[:comment].merge(
        from_user_name: current_user.twitter_handle,
        twitter_handle: current_user.twitter_handle,
        twitter_profile_image_url: current_user.twitter_profile_image_url,
        tweeted_at: Time.now))
    @comment.save!

    if @comment.post_to_twitter.to_i == 1
      status = current_user.twitter_client.update(
        @story.twitter_handle + ' ' + @comment.content,
        in_reply_to_status_id: @story.twitter_id)

      @comment.twitter_id = status.id
      @comment.tweeted_at = Time.now
      @comment.save
    end

    redirect_to(story_path(@story))
  end
end
