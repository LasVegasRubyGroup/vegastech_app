class TicketCakeFetcher
  require 'open-uri'

  def self.get_events
    xml_event_data = open("http://ticketcake.com/events/nv/rss.xml").read

    event_data_hash = Hash.from_xml(xml_event_data)

    event_data_hash['rss']['channel']['item'].each do |event|
      Story.find_or_create_by_ticket_cake_id(event)
    end
  end

  def self.story_content(event_data)
    "#{event_data['title']} - RSVP and details: #{event_data['link']} (via Ticket Cake API)"
  end

end