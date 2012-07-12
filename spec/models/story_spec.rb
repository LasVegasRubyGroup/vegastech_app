require 'spec_helper'

describe Story do
  context "when performing validations" do

  	let(:story) { Story.new(twitter_handle: "@fredguest", content: "once upon a time") }

  	it "should be valid with default values" do
  		story.should be_valid
  	end

  	it "should not be valid without a twitter handle" do
  		story.twitter_handle = nil
  		story.should be_invalid
  	end

    it "should not be valid with a duplicate twitter_id" do
        story.twitter_id = "fake_id"
        story.save
        story2 = Story.new(:twitter_id => "fake_id", :twitter_handle => '@SomeHandle', :content => "My tweet.")
        story2.should be_invalid
    end 

  	it "should not be valid without content" do
  		story.content = nil
  		story.should be_invalid
  	end

  	it "should not be valid without @ at beginning of twitter handle" do

  		story.twitter_handle = "twitterdude"
  		story.should be_invalid
  	end

  	it "should not be valid with non-word characters in twitter handle" do

  		story.twitter_handle = "@twitter dude"
  		story.should be_invalid
  	end
  end

  context "When calculating ranking" do
    let(:story) { Story.new(twitter_handle: "@fredguest", content: "once upon a time") }
    it "should have some votes"    do
      story.should respond_to(:votes)
    end

    it "should have a rank" do
      story.should respond_to(:rank)
    end

    it "should have a rank that is 1 with one new up vote and one new down vote" do
      story.save
      vote1 = story.votes.create(twitter_handle: "@fredguest", value: 1)
      vote2 = story.votes.create(twitter_handle: "@dylansimpson", value: -1)
      story.rank.should == 1
    end

    it "should have a rank that is 2 with one up vote" do
      story.save
      vote1 = story.votes.create(twitter_handle: "@fredguest", value: 1)
      story.rank.should == 2
    end

    it "should have a rank that is 0 with one down vote" do
      story.save
      vote1 = story.votes.create(twitter_handle: "@fredguest", value: -1)
      story.rank.should == 0
    end

    it "it should have a rank of the sum of the value of it votes" do
      story.save
      FactoryGirl.create(:vote, post: story)
    end

    it "should retweet a story with 10 votes" do
      story.save
      story.should_receive(:retweet)
      10.times do |i|
        vote = story.votes.build(twitter_handle: "@usr#{i}", value: 1)
        vote.stub(:post).and_return(story)
        vote.save
      end
    end
  end

  context "when creating a story" do
    let(:story) { Story.new(twitter_handle: "@fredguest", content: "once upon a time") }

    it "should create a vote for the author on their own story" do
      story.save
      story.votes.count.should == 1
      story.votes.first.twitter_handle.should == story.twitter_handle
    end
  end

  describe '#retweet' do
    it "should call retweet on twitter library" do
      story = Story.new
      Logger.should_receive(:debug)
      story.retweet
    end
  end 
end


