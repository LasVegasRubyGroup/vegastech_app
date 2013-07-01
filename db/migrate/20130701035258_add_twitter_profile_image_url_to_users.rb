class AddTwitterProfileImageUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_profile_image_url, :string
  end
end
