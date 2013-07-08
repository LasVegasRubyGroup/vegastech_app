class MeetupFetcher
  require 'open-uri'
  require 'json'

  def self.get_events
    meetup_data = JSON.parse(open("https://api.meetup.com/2/open_events.json?text=#{ENV['TRACK_HASHTAG']}&key=#{ENV['MEETUP_KEY']}").read)

    meetup_data['results'].each do |event|
      Story.find_or_create_by_meetup_id(event)
    end
  end

  def self.meetup_story_content(event_data)
    "#VegasTech Event: #{event_data['name']} - RSVP and details:  #{event_data['event_url']} "
  end

end