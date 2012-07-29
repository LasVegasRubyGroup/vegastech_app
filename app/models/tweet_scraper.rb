class TweetScraper 
  def self.get_latest 
    Twitter.search('#vegastech -rt', :rpp => 100).results.each do |tweet|
      Story.create(:twitter_id => tweet.id.to_s, :twitter_handle => "@"+tweet.from_user, :content => tweet.text, :tweeted_at => tweet.created_at)
    end
  end 
end
