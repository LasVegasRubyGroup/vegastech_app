class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :content
      t.string :twitter_handle
      t.integer :story_id

      t.timestamps
    end
    
    add_index :stories, :twitter_handle
    add_index :stories, :story_id
    add_index :stories, :created_at
    
  end
end
