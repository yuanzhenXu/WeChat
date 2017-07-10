class WechatUser < ApplicationRecord
  # validates :openid
  # has_many :wechat_tags, through: :user_wechat_tag

  def sendmessage(text_message)
    message = Wechat.api.message_send(@wechat_user.openid, text_message)
  end

end
