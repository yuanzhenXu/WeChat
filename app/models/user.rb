class User < ApplicationRecord
  include WechatTaggable

  validates :nickname, presence: true
  validates :openid, presence: true, if: 'is_admin = false'

  has_secure_password

  # has_many  :wechat_tags, dependent: :destroy
  has_many  :shared_logs, dependent: :destroy
  has_many  :view_logs
  has_many  :addresses

  # has_many  :wechat_tags, through: :user_wechat_tags, dependent: :destroy

  enum role: [:'土豆', '香蕉', '小黄人']

  # before_validation :generate_passowrd, if: 'password_digest.blank?'

  scope :admin, -> { where(is_admin: true) }
  scope :not_admin, -> { where(is_admin: false) }

  def generate_passowrd
    password = random_code_with_string(8)
    self.password = password
    return true
  end

  def random_code_with_string(number)
    charset = Array('0'..'9') + Array('a'..'z') + Array('0'..'9')
    Array.new(number) { charset.sample }.join
  end



  # before_action :logged_in_user, only:[:edit, :update]

  def self.find_or_initilize_via_wechat(openid)
    user = self.where(openid)
    user.openid = openid
    return user
  end

  def self.find_or_create_via_wechat(openid)
    user = self.find_or_initilize_via_wechat(openid)
    user.save
  end

  def admin?
    !!is_admin
  end

end
