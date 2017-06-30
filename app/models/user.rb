class User < ApplicationRecord
  validates :name, presence: true
  validates :wechat_num, presence: true

  def self.find_or_initilize_via_wechat(openid)
    user = self.where(openid).first
    user.openid = openid
    return user
  end

  def self.find_or_create_via_wechat(openid)
    user = self.find_or_initilize_via_wechat(openid)
    user.save
  end

end
