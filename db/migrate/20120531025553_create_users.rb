class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_handle
      t.string :uid

      t.timestamps
    end

    add_index :users, :twitter_handle
    add_index :users, :uid
  end
end
