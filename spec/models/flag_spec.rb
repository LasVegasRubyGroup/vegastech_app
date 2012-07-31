require 'spec_helper'


describe Flag do
  context "when validating a flag" do
    let(:story) { Story.create(twitter_handle: "@lvrug", content: "once upon a time", from_user_name: "Las Vegas Ruby Group") }
    let(:flag) { story.flags.build(twitter_handle: "@fredguest") }
    it "should be valid with required values" do
      flag.should be_valid
    end

    it "should be_invalid without a twitter_handle" do
      flag.twitter_handle=nil
      flag.should be_invalid
    end

    it "should be_invalid without a post_id" do
      flag.post_id = nil
      flag.should be_invalid
    end

    it "should not be valid without @ at beginning of twitter handle" do
      flag.twitter_handle = "twitterdude"
      flag.should be_invalid
    end

    it "should not be valid with non-word characters in twitter handle" do
      flag.twitter_handle = "@twitter dude"
      flag.should be_invalid
    end

    it "should have a story" do
      flag.should respond_to(:story)
    end

    it "should only allow one flag per twitter_handle per story" do
      flag.save
      flag2 = story.flags.build(twitter_handle: "@fredguest")
      flag2.should be_invalid
    end

   end
end
