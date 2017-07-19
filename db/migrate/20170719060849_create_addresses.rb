class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :user_id, index: true
      t.string :name
      t.string :province
      t.string :city
      t.string :province_code
      t.string :city_code
      t.string :street
      t.string :zipcode
      t.boolean :is_default, default: false, index: true

      t.timestamps
    end
  end
end
