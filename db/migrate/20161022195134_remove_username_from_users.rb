class RemoveUsernameFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :username, :citext
    remove_column :users, :phone_number, :string
  end
end
