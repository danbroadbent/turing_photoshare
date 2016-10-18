class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'
    create_table :albums do |t|
      t.citext :title
      t.citext :description
      t.boolean :public, default: false

      t.timestamps
    end
  end
end
