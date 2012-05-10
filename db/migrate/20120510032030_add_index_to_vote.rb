class AddIndexToVote < ActiveRecord::Migration
  def change
    add_index :votes, [:twitter_handle, :story_id], unique: true
  end
end