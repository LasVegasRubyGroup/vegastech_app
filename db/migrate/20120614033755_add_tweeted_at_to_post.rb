class AddTweetedAtToPost < ActiveRecord::Migration
  def change
    add_column :posts, :tweeted_at, :datetime
    add_index :posts, :tweeted_at
  end
end
