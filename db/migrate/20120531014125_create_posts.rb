class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.string :twitter_handle
      t.string :type
      t.integer :story_id

      t.timestamps
    end

    add_index :posts, :twitter_handle
    add_index :posts, :story_id
    add_index :posts, :type

    drop_table :stories
    drop_table :comments
  end
end
