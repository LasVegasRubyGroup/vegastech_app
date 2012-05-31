class RenameStoryId < ActiveRecord::Migration
  def change
    rename_column :votes, :story_id, :post_id
    rename_column :flags, :story_id, :post_id
  end

end
