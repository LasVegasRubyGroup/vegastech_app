require 'spec_helper'

describe TweetScraper do 
  describe ".get_latest" do

    before(:each) do 
      Struct.new("Status", :id, :from_user, :text, :created_at)
      @tweet1 = Struct::Status.new(1, "SomeUser", "This is my tweet.", 1.minute.ago )
      @tweet2 = Struct::Status.new(2, "SomeOtherUser", "This is yet another tweet.", 2.minutes.ago )
      @tweet3 = Struct::Status.new(1, "SomeOtherUser", "This is yet another tweet.", 3.minutes.ago )
    end
  
    it "should search tweets" do
      Twitter.stub(:search).and_return([@tweet1, @tweet2])
      Twitter.should_receive(:search).with('#vegastech -rt', :rpp => 100)
      TweetScraper.get_latest
    end

    it "should store tweets as stories in the database" do 
      Twitter.stub(:search).and_return([@tweet1, @tweet2])
      TweetScraper.get_latest
      Story.first.twitter_id.should == "1"
    end
    
    it "should ignore duplicate tweets" do
      Twitter.stub(:search).and_return([@tweet1, @tweet2, @tweet3])
      TweetScraper.get_latest
      Story.count.should == 2
    end

    it "should create some stories when used in a live environment" do
      TweetScraper.get_latest
      Story.count.should > 0
    end
  end
end
