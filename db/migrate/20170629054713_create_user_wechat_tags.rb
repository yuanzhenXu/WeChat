class CreateUserWechatTags < ActiveRecord::Migration[5.1]
  def change
    create_table :user_wechat_tags do |t|
      t.references :user
      t.references :wechat_tag

      t.timestamps
    end
  end
end
