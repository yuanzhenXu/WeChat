require 'active_support/concern'
module WechatTaggable

  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :wechat_tags, after_add: :add_to_wechat, after_remove: :remove_from_wechat

  end

  def add_to_wechat(wechat_tag)
    p ' **' * 20
    p 'add_to_wechat'
    res = Wechat.api.tag_add_user(wechat_tag.tagid, Array(self.openid))
    return true
  end

  def remove_from_wechat(wechat_tag)
    # p ' **' * 20
    # p 'remove_from_wechat'
    res = Wechat.api.tag_del_user(wechat_tag.tagid, Array(self.openid))
    return true
  end

  def update_role_tag
    _old_tags = self.wechat_tags.as_role
    if _old_tags.present?
      _old_tags.each do |t|
        self.wechat_tags.delete(t)
      end
    end

    _tag = WechatTag.find_by(
        name: User.human_attribute_name("role.#{role}"),
        tag_type: WechatTag.tag_types['as_role']
    )
    if _tag.blank?
      _tag = WechatTag.create(
          name: User.human_attribute_name("role.#{role}"),
          tag_type: 'as_role'
      )
    end

    self.wechat_tags.push(_tag)
  end

  def update_group_tag
    _old_tags = self.wechat_tags.as_group
    if _old_tags.present?
      _old_tags.each do |t|
        self.wechat_tags.delete(t)
      end
    end

    if self.group
      _tag = WechatTag.find_by(
          name: self.group.name,
          tag_type: WechatTag.tag_types['as_group']
      )
      if _tag.blank?
        _tag = WechatTag.create(
            name: self.group.name,
            tag_type: 'as_group'
        )
      end
      self.wechat_tags.push(_tag)
    end
  end

  # 同步到微信标签
  def sync_from_wechat!
    _hash = Wechat.api.user(openid)
    # {"subscribe"=>1, "openid"=>"omrsEwtXp-2S3p86CF8P1PsCMa_M", "nickname"=>"罗平", "sex"=>2, "language"=>"zh_CN", "city"=>"", "province"=>"上海", "country"=>"中国", "headimgurl"=>"http://wx.qlogo.cn/mmopen/GD0Cf7KQJhG5icRGpzJicXFiaFsBnXbJG3K74ULSDSWbIA3PV33l2ms9PqNNADxUdcv8S22NbLwspwWvtO1VNCXIzSafGY4QEDa/0", "subscribe_time"=>1492580079, "unionid"=>"ozD-9s8zXy7zfmtLIEYEZz61NcDw", "remark"=>"", "groupid"=>103, "tagid_list"=>[103, 119, 104]

    self.attributes = {
        nickname: _hash['nickname'],
        headimageurl: _hash['headimgurl']
    }
    self.save

    # account = self.wechat_account || self.build_wechat_account
    # _hash.each do |k, v|
    #   account[k] = v
    # end
    #
    # account.save
  end


end