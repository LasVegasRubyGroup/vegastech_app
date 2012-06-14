class AddTwitterIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :twitter_id, :string
    add_index :posts, :twitter_id, :unique => true
  end
end
