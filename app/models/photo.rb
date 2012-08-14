class Photo < Post
  belongs_to :story

  attr_accessible :story_id

  def self.create_from_story_and_media(story, media)
    media.each do |media|
      self.create!(
        story_id: story.id,
        twitter_handle: story.twitter_handle,
        content: media['media_url'],
        tweeted_at: story.created_at,
        from_user_name: story.from_user_name)
      print 'p'
    end
  end
end
