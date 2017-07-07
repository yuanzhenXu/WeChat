class AddTagTypeToWechatTags < ActiveRecord::Migration[5.1]
  def change
    add_column :wechat_tags, :tag_type, :integer, default: 0
  end
end
