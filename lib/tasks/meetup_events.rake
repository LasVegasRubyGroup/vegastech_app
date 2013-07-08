namespace :meetup_api do
  desc "Pull events with the #{ENV['TRACK_HASHTAG']} in the description."
  task pull_events: :environment do
    MeetupFetcher.get_events
  end
end
