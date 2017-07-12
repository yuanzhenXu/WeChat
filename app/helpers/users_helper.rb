module UsersHelper

  def user_role_color(role)
    if role.is_a?(Fixnum)
      role = User.roles.key(role)
    end

    case role.to_sym
      when '土豆'
        'plain'
      when '香蕉'
        'success'
      when '小黄人'
        'danger'
    end
  end

  def user_group_color(group_id)
    return '' if group_id.blank?

    colors = %w(plain success info primary danger)
    i = group_id%colors.size
    colors.fetch(i-1)
  end

end
