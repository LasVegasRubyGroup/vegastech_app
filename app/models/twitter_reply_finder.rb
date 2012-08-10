class TwitterReplyFinder
  def check_replies(tweet_id,original_id)
    results = RestClient.get(checker_url_for(tweet_id))
    tweets = JSON.parse(results)
    comments = []
    if tweets.any?
      story = Story.find_by_twitter_id(original_id)
      tweets.each do |tweet|
        unless comment_exists?(tweet)
          comment = create_comment(story, tweet)
          comments << comment
        end
      end
    end
    comments
  end

  def comment_exists?(tweet)
    Comment.exists?(twitter_id: reply_id(tweet))
  end

  def create_comment(story,tweet)
    story.comments.create do |comment|
      comment.twitter_id = reply_id(tweet)
      comment.twitter_handle = reply_handle(tweet)
      comment.content = reply_content(tweet)
      comment.tweeted_at = reply_created_at(tweet)
      comment.from_user_name = reply_from_user_name(tweet)
    end
  end

  def reply_created_at(tweet)
    tweet["results"][0]["value"]["created_at"]
  end

  def reply_content(tweet)
    tweet["results"][0]["value"]["text"]
  end

  def reply_handle(tweet)
    "@" + tweet["results"][0]["value"]["user"]["screen_name"]
  end

  def reply_from_user_name(tweet)
    tweet["results"][0]["value"]["user"]["name"]
  end

  def reply_id(tweet)
    tweet["results"][0]["value"]["id"]
  end

  def checker_url_for(tweet_id)
    "https://api.twitter.com/1/related_results/show/#{tweet_id}.json?include_entities=1"
  end
end
