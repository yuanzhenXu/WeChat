class User < ApplicationRecord
  validates :nickname, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true

  # before_action :logged_in_user, only:[:edit, :update]

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
