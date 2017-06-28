class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :groupid
      t.string :openid
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
