class AddAuthCredentialsToUser < ActiveRecord::Migration
  def change
    User.destroy_all
    add_column :users, :auth_credentials, :string
  end
end
