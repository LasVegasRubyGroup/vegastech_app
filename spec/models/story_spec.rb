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

    it "should have a rank that is 0 with one up vote and one down vote" do
      story.save
      vote1 = story.votes.create(twitter_handle: "@fredguest", value: 1)
      vote2 = story.votes.create(twitter_handle: "@dylansimpson", value: -1)
      story.rank.should == 0
    end

    it "should have a rank that is 1 with one up vote" do
      story.save
      vote1 = story.votes.create(twitter_handle: "@fredguest", value: 1)
      story.rank.should == 1
    end

    it "should have a rank that is -1 with one down vote" do
      story.save
      vote1 = story.votes.create(twitter_handle: "@fredguest", value: -1)
      story.rank.should == -1
    end

    it "it should have a rank of the sum of the value of it votes" do
      story.save
      FactoryGirl.create(:vote, post: story)
    end

  end
end


