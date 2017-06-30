class CreateWechatTags < ActiveRecord::Migration[5.1]
  def change
    create_table :wechat_tags do |t|
      t.string :name
      t.integer :user_count

      t.timestamps
    end
  end
end
