require 'spec_helper'

describe Story do
  context "when performing validations" do
  	it "should not be valid without a twitter handle" do
  		story = Story.new 
  		story.should be_invalid
  	
  	end
  
  end
  
end
