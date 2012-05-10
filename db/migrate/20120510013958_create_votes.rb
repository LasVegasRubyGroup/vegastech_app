class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :twitter_handle
      t.integer :value
      t.integer :story_id

      t.timestamps
    end
    add_index :votes, :twitter_handle
    add_index :votes, :story_id
  end
end
