class AddTagidToWechatTags < ActiveRecord::Migration[5.1]
  def change
    add_column :wechat_tags, :tagid, :integer
  end
end
