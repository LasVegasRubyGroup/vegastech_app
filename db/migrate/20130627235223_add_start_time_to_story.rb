class AddStartTimeToStory < ActiveRecord::Migration
  def change
    add_column :posts, :start_time, :datetime
  end
end
