namespace :pull_events do
  desc "Pull events with the #{ENV['TRACK_HASHTAG']} in the description."
  task meetup: :environment do
    MeetupFetcher.get_events
  end

  desc "Pull events with the #{ENV['TRACK_HASHTAG']} in the description."
  task ticket_cake: :environment do
    TicketCakeFetcher.get_events
  end

  desc "Pull all events in."
  task all_sources: ['pull_events:meetup', 'pull_events:ticket_cake']

end
