module Admin::BaseHelper
  def body_bg
    return 'gray-bg' if empty_page?
    return ''
  end

  def page_wrapper_bg
    return '' if empty_page?
    return 'gray-bg'
  end

  # Empty page: login ..
  # no navbar, navbar header, bg shuld be gray-bg
  def empty_page?
    controller_name == 'sessions'
  end

  def nav_class(item)
    case item
      when 'users'
        return 'active' if %w(users consultant_infos groups).include?(controller_name)
        return 'active' if %w(wechat_logs reward_histories).include?(controller_name) && @user.present?
      when 'wechat'
        return 'active' if %w(links wechat_tags).include?(controller_name)
      when 'products'
        return 'active' if %w(products option_types properties product_properties variants images stores shelves).include?(controller_name)
      when 'settings'
        return 'active' if %w(shipping_categories hospitals departments banners faqs tags).include?(controller_name)
      when 'logs'
        return 'active' if %w(share_logs view_logs points).include?(controller_name)
        return 'active' if %w(wechat_logs reward_histories).include?(controller_name) && @user.blank?
      when 'articles'
        return 'active' if %w(articles categories).include?(controller_name)
      when 'games'
        return 'active' if %w(game_details game_chances game_prize_pools game_histories).include?(controller_name)
    end

    return 'active' if item == controller_name
    return ''
  end

  def subnav_class(item)
    case item
      when 'products'
        return 'active' if %w(products product_properties variants images).include?(controller_name)
      when 'users'
        return 'active' if %w(wechat_logs reward_histories).include?(controller_name) && @user.present?
    end

    return 'active' if item == controller_name
    return ''
  end

  def link_to_delete(resource, url, options={})
    name = options[:name] || t(:delete)
    options[:class] = "btn btn-danger btn-sm  delete-resource"
    options[:data] = { confirm: t(:are_you_sure), action: 'remove' }
    link_to name, url, options.merge({ method: :delete })
  end

  def have_new_btn?
    return false if %w(orders shipping_categories tixians settings).include?(controller_name)
    return true
  end

  def enum_color(_id)
    return '' if _id.blank?
    colors = %w(plain primary info success warning danger)
    colors[_id%6]
  end

end
