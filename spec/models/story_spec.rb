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
  		pending
  		story.twitter_handle = "twitterdude"	
  		story.should be_invalid
  	end
  	
  	it "should not be valid with non-word characters in twitter handle" do
  		pending
  		story.twitter_handle = "@twitter dude"	
  		story.should be_invalid
  	end
  end
end
