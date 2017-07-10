class User < ApplicationRecord
  validates :nickname, presence: true

  has_many  :wechat_tags, dependent: :destroy
  has_many  :shared_logs, dependent: :destroy
  has_many  :wechat_tags, through: :user_wechat_tags

  # has_secure_password


  # before_action :logged_in_user, only:[:edit, :update]

  # def self.find_or_initilize_via_wechat(openid)
  #   user = self.where(openid).first
  #   user.openid = openid
  #   return user
  # end
  #
  # def self.find_or_create_via_wechat(openid)
  #   user = self.find_or_initilize_via_wechat(openid)
  #   user.save
  # end

end
