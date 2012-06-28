FactoryGirl.define do
  factory :story do |s|
    s.sequence(:content) {|n| "a story #{n}"}
    s.sequence(:twitter_handle) {|n| "@user#{n}"}
  end

  factory :vote do |v|
    value 1
    v.sequence(:twitter_handle) {|n| "@user#{n}"}
    association :post
    factory :down_vote do
      value -1
    end
  end

  factory :user do |u|
    u.sequence(:twitter_handle) {|n| "@user#{n}"}
    u.sequence(:uid) {|n| "#{n}"}
  end
end
