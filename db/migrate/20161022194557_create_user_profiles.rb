class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.string :username
      t.string :email
      t.string :phone_number
      t.references :user, foreign_key: true
      t.string :bio

      t.timestamps
    end
  end
end
