class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.string :twitter_handle, null: false
      t.integer :story_id, null: false

      t.timestamps
    end
  end
end
