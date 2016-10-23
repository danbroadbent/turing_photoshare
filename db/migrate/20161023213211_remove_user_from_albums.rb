class RemoveUserFromAlbums < ActiveRecord::Migration[5.0]
  def change
    remove_reference :albums, :user, foreign_key: true
  end
end
