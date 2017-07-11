class CreateUserWechatTags < ActiveRecord::Migration[5.1]
  def change
    create_table :user_wechat_tags do |t|
      t.integer :user_id

      t.integer :wechat_tag_id

      t.timestamps
    end
  end
end
