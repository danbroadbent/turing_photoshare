class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'
    create_table :photos do |t|
      t.citext :caption
      t.references :album, foreign_key: true
      t.references :user, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
