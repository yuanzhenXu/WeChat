class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :require_admin

  def require_admin
    if current_admin.blank?
      if wechat_agent?
        redirect_to wechat_home_path
      else
        redirect_to admin_root_path, alert: '请先登录'
      end
    end
  end

  helper_method :current_admin
  def current_admin
    return @current_admin if @current_admin.present?
    @current_admin = User.admin.find_by(id: session[:admin_id]) if session[:admin_id].present?
  end

  def current_admin=(user)
    return nil if user.blank?
    session[:admin_id] = session[:user_id] = user.id
    @current_admin = user
  end

end

