module ApplicationHelper
  include Twitter::Autolink

  def link_from_handle(handle)
    'http://twitter.com/' + handle.gsub(/^@/, '')
  end

  def link_from_story(story)
    link_from_handle(story.twitter_handle) + '/status/' + story.twitter_id
  end
end
