class AddPhoneToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :phone, :string
  end
end
