class CreateAlbumUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :album_users do |t|
      t.references :user, foreign_key: true
      t.references :album, foreign_key: true
      t.boolean :owner

      t.timestamps
    end
  end
end
