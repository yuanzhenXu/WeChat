class CreateWechatUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :wechat_users do |t|
      t.string :openid
      t.string :nickname
      t.string :event
      t.datetime :subscribe_at
      t.datetime :unsubscribe_at
      t.timestamps
    end
  end
end
