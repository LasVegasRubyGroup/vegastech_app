require 'spec_helper'

describe User do
  describe '#voted_on?' do 
    let(:user) { User.create(twitter_handle: '@bobfirestone', uid: '1234') }
    let(:story) { Story.create(twitter_handle: "@fredguest", content: "once upon a time") }

    it 'should be false if the user has not voted on a story' do
      user.voted_on?(story).should_not be
    end

    it 'should be true if the user has voted on a story' do
      user.up_vote(story)
      user.voted_on?(story).should be
    end
  end

  describe '#up_vote' do 
    let(:user) { User.create(twitter_handle: '@bobfirestone', uid: '1234') }
    let(:story) { Story.create(twitter_handle: "@fredguest", content: "once upon a time") }

    it 'should increase the rank of the story by one' do
      expect{ user.up_vote(story) }.to change{story.rank}.by(1)
    end
  end
end
