module Wechat::BaseHelper

  def current_signature
    @signature ||= Wechat.api.jsapi_ticket.signature(request.url)[:signature]
  end

  def use_default_share_uri?
    case controller_name
      when 'wechat_tags', 'welcome', 'users', 'wechat_users'
        return true
    end

    return false
  end

  def share_uri
    @shared_uri = root_url(shared_user_id: current_user.try(:id))
    return @share_uri if @share_uri.present?
    if use_default_share_uri?
      root_url(shared_user_id: current_user.try(:id))
    else
      url_for(params.merge(shared_user_id: current_user.try(:id), only_path: false).permit!)
    end
  end

  def hide_share
    # return true if controller_name == 'consultants' && action_name == 'qrcode'
    # return true if controller_name == 'games'
    # return true if controller_name == 'home' && action_name == 'protocol'
    # return false
  end
end
