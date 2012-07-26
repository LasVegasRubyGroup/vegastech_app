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

    it "should have a vote_count" do
      story.should respond_to(:vote_count)
    end

    it "should have a vote_count that is 1 with one new up vote and one new down vote" do
      story.save
      vote1 = story.votes.create(twitter_handle: "@fredguest", value: 1)
      vote2 = story.votes.create(twitter_handle: "@dylansimpson", value: -1)
      story.vote_count.should == 1
    end

    it "should have a vote_count that is 2 with one up vote" do
      story.save
      vote1 = story.votes.create(twitter_handle: "@fredguest", value: 1)
      story.vote_count.should == 2
    end

    it "should have a vote_count that is 0 with one down vote" do
      story.save
      vote1 = story.votes.create(twitter_handle: "@fredguest", value: -1)
      story.vote_count.should == 0
    end

    it "it should have a vote_count of the sum of the value of it votes" do
      story.save
      FactoryGirl.create(:vote, post: story)
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

  describe "#age" do
    context "for a tweet 1 day old" do
      let(:story) { Story.new(twitter_handle: "@fredguest", content: "once upon a time", tweeted_at: 1.day.ago) }
      it "should be 2" do
        story.age.should be_within(0.01).of(2)
      end
    end
  end
end


