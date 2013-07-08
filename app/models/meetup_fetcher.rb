class MeetupFetcher
  require 'open-uri'
  require 'json'

  def self.get_events
    meetup_data = JSON.parse(open("https://api.meetup.com/2/open_events.json?text=#{ENV['TRACK_HASHTAG']}&key=1d4347a6e20ed253895c2a265161").read)

    meetup_data['results'].each do |event|
      Story.create_from_meetup(event)
    end
  end

  def self.meetup_story_content(event_data)
    "#{event_data['name']} - RSVP and details:  #{event_data['event_url']} "
  end

end