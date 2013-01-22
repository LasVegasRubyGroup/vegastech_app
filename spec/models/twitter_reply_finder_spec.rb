require 'spec_helper'

describe TwitterReplyFinder do

  let(:test_tweet) { "[{\"results\":[{\"score\":1.0,\"annotations\":{\"ConversationRole\":\"Descendant\"},\"kind\":\"Tweet\",\"value\":{\"contributors\":null,\"coordinates\":null,\"user\":{\"show_all_inline_media\":false,\"id\":203153728,\"location\":\"\",\"follow_request_sent\":null,\"profile_image_url\":\"http:\/\/a0.twimg.com\/profile_images\/1825418888\/rocket-moon_normal.jpg\",\"profile_background_color\":\"642D8B\",\"statuses_count\":1792,\"utc_offset\":-28800,\"profile_image_url_https\":\"https:\/\/si0.twimg.com\/profile_images\/1825418888\/rocket-moon_normal.jpg\",\"name\":\"Elizabeth Yin\",\"default_profile\":false,\"profile_background_image_url\":\"http:\/\/a0.twimg.com\/images\/themes\/theme10\/bg.gif\",\"screen_name\":\"launchbit\",\"friends_count\":556,\"profile_link_color\":\"FF0000\",\"protected\":false,\"notifications\":null,\"profile_use_background_image\":true,\"lang\":\"en\",\"listed_count\":72,\"profile_text_color\":\"3D1957\",\"description\":\"\",\"followers_count\":1153,\"url\":\"http:\/\/www.launchbit.com\",\"is_translator\":false,\"created_at\":\"Fri Oct 15 17:06:41 +0000 2010\",\"profile_sidebar_border_color\":\"65B0DA\",\"contributors_enabled\":false,\"verified\":false,\"time_zone\":\"Pacific Time (US & Canada)\",\"geo_enabled\":false,\"id_str\":\"203153728\",\"default_profile_image\":false,\"profile_background_tile\":true,\"profile_background_image_url_https\":\"https:\/\/si0.twimg.com\/images\/themes\/theme10\/bg.gif\",\"following\":null,\"profile_sidebar_fill_color\":\"7AC3EE\",\"favourites_count\":2},\"retweeted\":false,\"in_reply_to_status_id\":232558689528197120,\"in_reply_to_user_id\":7832572,\"truncated\":false,\"in_reply_to_status_id_str\":\"232558689528197120\",\"retweet_count\":0,\"source\":\"web\",\"id_str\":\"232558888698929152\",\"entities\":{\"hashtags\":[],\"urls\":[],\"user_mentions\":[{\"name\":\"Zach Ware\",\"indices\":[0,9],\"screen_name\":\"zachware\",\"id_str\":\"7832572\",\"id\":7832572},{\"name\":\"Vegas Tech\",\"indices\":[10,20],\"screen_name\":\"VegasTech\",\"id_str\":\"384587314\",\"id\":384587314},{\"name\":\"Vegas Tech Fund\",\"indices\":[21,35],\"screen_name\":\"VegasTechFund\",\"id_str\":\"531284542\",\"id\":531284542}]},\"geo\":null,\"id\":232558888698929152,\"created_at\":\"Mon Aug 06 19:28:54 +0000 2012\",\"in_reply_to_user_id_str\":\"7832572\",\"place\":null,\"in_reply_to_screen_name\":\"zachware\",\"favorited\":false,\"text\":\"@zachware @VegasTech @VegasTechFund thanks!  we're excited!\"}}],\"resultType\":\"Tweet\",\"score\":1.0,\"groupName\":\"TweetsWithConversation\",\"annotations\":{\"FromUser\":\"zachware\"}}]" }

  let!(:original_tweet) { Story.create(twitter_id: '232558689528197120', twitter_handle: '@zachware', content: 'Some Tweet #vegastech', from_user_name: 'Jim Jones') }

  let(:finder) { TwitterReplyFinder.new }

  it "should call rest client to check the replies" do
    RestClient.stub(:get).and_return(test_tweet)
    RestClient.should_receive(:get)
    finder.check_replies('232558689528197120','232558689528197120')
  end

  it "should insert any new replies it finds" do
    RestClient.stub(:get).and_return(test_tweet)
    finder.check_replies('232558689528197120','232558689528197120')
    original_tweet.reload
    original_tweet.comments.count.should == 1
  end

  it "should not duplicate comments" do
    RestClient.stub(:get).and_return(test_tweet)
    finder.check_replies('232558689528197120','232558689528197120')
    finder.check_replies('232558689528197120','232558689528197120')
    original_tweet.reload
    original_tweet.comments.count.should == 1
  end

  it "should return the number of comments added" do
    # RestClient.stub(:get).and_return(test_tweet)
    # finder.check_replies('232558689528197120','232558689528197120').should == 1
  end

end