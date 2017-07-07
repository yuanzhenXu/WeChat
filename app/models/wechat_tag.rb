class WechatTag < ApplicationRecord

  enum tag_types: [:as_normal, :as_role, :as_group]
  validates :name, presence:true, uniqueness:true

  has_and_belongs_to_many :users, through: :user_wechat_tag

  before_create :add_to_wechat
  after_create  :update_to_wechat
  after_destroy :delete_to_wechat

  def add_to_wechat
    res = Wechat.api.wechat_tag_create(self.name)
    unless res.nil?
      flash[:notice] = "微信标签添加成功"
    end

  end

  def update_to_wechat
    res = Wechat.api.wechat_tag_update(self.name)
    unless res.nil?
      flash[:notice] = "微信标签更新成功"
    end

  end

  def delete_to_wechat
    res = Wechat.api.wechat_tag_delete(self.name)
    unless res.nil?
      flash[:notice] = "微信标签删除成功"
    end
  end

end
