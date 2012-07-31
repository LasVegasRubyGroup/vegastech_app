class AddNameToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :from_user_name, :string
  end
end
