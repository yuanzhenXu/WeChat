module Admin::SessionsHelper
  # 返回当前登录的用户（如果有的话）
  def current_user
    return @current_user if @current_user.present?
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

end
