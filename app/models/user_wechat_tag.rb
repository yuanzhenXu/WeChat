class UserWechatTag < ApplicationRecord
  belongs_to :user
  belongs_to :wechat_tag
end
