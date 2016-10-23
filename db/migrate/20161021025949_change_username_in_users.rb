class ChangeUsernameInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :username, :string
  end
end
