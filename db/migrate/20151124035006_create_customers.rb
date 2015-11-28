class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name, limit: 25, null: false
      t.string :last_name, limit: 25
      t.string :mobile_phone
      t.string :phone
      t.string :email, unique: true
      t.string :card_id, null: false
      t.string :token
      t.string :password
      t.text :address, limit: 50
      t.string :city
      t.string :nationality
      t.string :country
      t.integer :status
      t.timestamps null: false
    end
  end
end
