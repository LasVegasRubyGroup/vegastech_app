require 'spec_helper'


describe Vote do
  context "when validating a vote" do
    let(:story) { Story.create(twitter_handle: "@fredguest", content: "once upon a time") }
    let(:vote) { Vote.new(story_id: story.id, twitter_handle: "@fredguest", value: 1) }
    it "should be valid with required values" do
      vote.should be_valid
    end
    
    it "should be_invaild without a twitter_handle" do
      vote.twitter_handle=nil
      vote.should be_invalid
    end
    
    it "should be_invalid without a value" do
      vote.value =nil
      vote.should be_invalid
    end

    it "should be_invalid without a story_id" do
      vote.story_id =nil
      vote.should be_invalid
    end
    
    it "should not be valid without @ at beginning of twitter handle" do
      vote.twitter_handle = "twitterdude"  
      vote.should be_invalid
    end
    
    it "should not be valid with non-word characters in twitter handle" do
      vote.twitter_handle = "@twitter dude"  
      vote.should be_invalid
    end

    it "should be_invalid unless value is 1 or -1" do
      vote.value = -1
      vote.should be_valid
      vote.value = 3
      vote.should be_invalid
      vote.value = -3
      vote.should be_invalid
      vote.value = 0
      vote.should be_invalid
    end

    it "should have a story" do
      vote.should respond_to(:story)
    end

    it "should only allow one vote per twitter_handle" do
      vote.save
      vote2 = Vote.new(story_id: story.id, twitter_handle: "@fredguest", value: 1)
      vote2.should be_invalid
    end

  end
end
