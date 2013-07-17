module ApplicationHelper
  include Twitter::Autolink

  def link_from_handle(handle)
    'http://twitter.com/' + handle.gsub(/^@/, '')
  end

  def link_from_api_source(tweet_id)
    if tweet_id.include?('meetup')
      'http://www.meetup.com/'
    elsif tweet_id.include?('ticket_cake')
      'http://ticketcake.com/'
    else
      'http://vegastech.lvrug.org/'
    end
  end

  def link_from_story(story)
    return 'https://twitter.com/VegasTech_News' if story.twitter_id.include?('meetup')
    link_from_handle(story.twitter_handle) + '/status/' + story.twitter_id
  end
end
