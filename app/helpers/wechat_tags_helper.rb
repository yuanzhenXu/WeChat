module WechatTagsHelper
  def enum_color(_id)
    return '' if _id.blank?
    colors = %W(plain primary info success warning danger)
    colors[_id%6]
  end

  def have_new_btn?
    return false if %w(users wechat_tags).include?(controller_name)
    return true
  end
end
