class AddHeadimageurlToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :headimageurl, :string
  end
end
