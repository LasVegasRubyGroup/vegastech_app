class AddIconFontToTags < ActiveRecord::Migration
  def change
    add_column :tags, :icon_label, :string
  end
end
