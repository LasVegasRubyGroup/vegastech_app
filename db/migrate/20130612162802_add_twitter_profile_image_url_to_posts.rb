class AddTwitterProfileImageUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :twitter_profile_image_url, :string
  end
end
