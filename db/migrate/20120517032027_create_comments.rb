class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :story_id
      t.text :content
      t.string :twitter_handle

      t.timestamps
    end
  end
end
