class User < ActiveRecord::Base
  attr_accessible :twitter_handle, :uid
end
