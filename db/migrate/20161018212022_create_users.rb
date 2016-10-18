class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'
    create_table :users do |t|
      t.integer :role
      t.citext :username
      t.string :password_digest
      t.boolean :active
      t.string :verification_code

      t.timestamps
    end
  end
end
