class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :encrypted_password
      t.string :salt
      t.string :email
      t.string :phone_number
      t.string :token
      t.string :first_name
      t.string :last_name
      t.string :state
      t.string :city
      t.string :address
      t.string :social_id
      t.integer :social_type
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
