module ApplicationHelper
  include Twitter::Autolink

  def link_from_handle(handle)
    'http://twitter.com/' + handle.gsub(/^@/, '')
  end

  def link_from_story(story)
    return 'https://twitter.com/VegasTech_News' if story.twitter_id.include?('meetup')
    link_from_handle(story.twitter_handle) + '/status/' + story.twitter_id
  end
end
