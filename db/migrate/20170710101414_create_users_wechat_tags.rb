class CreateUsersWechatTags < ActiveRecord::Migration[5.1]
  def change
    create_table :users_wechat_tags do |t|
      t.references :user
      t.references :wechat_tag
    end
  end
end
