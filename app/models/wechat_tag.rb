class WechatTag < ApplicationRecord
  validates :name, presence:true, uniqueness:true

  has_and_belongs_to_many :users

  def add_to_wechat



  end

end
