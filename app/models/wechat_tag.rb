class WechatTag < ApplicationRecord

  enum tag_type: [:as_normal, :as_role, :as_group]

  validates :name, presence:true, uniqueness:true
  # has_many :users, through: :user_wechat_tags

  has_and_belongs_to_many :users

  before_create :add_to_wechat, if: 'tagid.blank?'
  after_create  :update_to_wechat, if: 'name_changed?'
  after_destroy :delete_to_wechat

  def add_to_wechat
    begin
      res = Wechat.api.tag_create(self.name)
      self[:tagid] = res['tag']['id']
      raise res if res['errmsg'] != 'ok'
    rescue => e
      _tags = Wechat.api.tags['tags']
      t = _tags.select{|t| t['name'] == self.name}
      if t.present?
        self[:tagid] = t[0]['id']
      else
        errors.add(:base, '不能添加微信标签')
        throw(:abort)
      end
    end
  end

  def update_to_wechat
    begin
      res = Wechat.api.tag_update(self.tagid, self.name)
      raise res if res['errmsg'] != 'ok'
    rescue
      errors.add(:base, '不能更新微信标签')
      # throw(:abort)
    end
  end

  def delete_to_wechat
    begin
      res = Wechat.api.tag_delete(self.tagid)
      raise res if res['errmsg'] != 'ok'
    rescue
      errors.add(:base, '未能删除微信标签')
      throw(:abort)
    end
  end

  def self.sync_from_wechat
    _tags = Wechat.api.tags['tags']
    _tags.each do |t|
      tag = WechatTag.find_or_initialize_by(name: t['name'])
      tag.tagid = t['id']
      tag.save(validate: false)
    end
  end

  def self.select_options
    self.all.pluck(:name, :id)
  end

  def self.tag_type_options
    self.tag_types.map{|k,v| [WechatTag.human_attribute_name("tag_type.#{k}"),k]}
  end
end
