module Admin::SessionsHelper

    #登入指定的用户
    def log_in(user)
      session[:user_id] = user.id
    end

    # 返回当前登录的用户（如果有的话）
    def current_user
      return @current_user if @current_user.present?
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
    end

    def current_user=(user)
      return nil if user.blank?
      session[:user_id] = user.id
      @current_user = user
    end

    def current_admin
      return @current_admin if @current_admin.present?
      @current_admin = User.find_by(id: session[:admin_id]) if session[:admin_id].present?
    end

    # 以管理员的身份登录
    def login_in_as_admin(user)
      session[:admin_id] = user.id
    end
    # 是否管理员登录
    def logged_in_as_admin?
      !@current_admin.nil?
      # @current_user.id.equal?(31)
    end

    # 如果用户已登录，返回 true，否则返回 false
    def logged_in?
      !current_user.nil?
    end

    # 退出当前用户
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

    # 管理员退出登录
    def log_out_admin
      session.delete(:admin_id)
      @current_admin = nil
    end

    def wechat_agent?
      user_agent = request.user_agent
      p '** '*20
      p user_agent
      return false if user_agent.blank?
      return /micromessenger/.match(user_agent.downcase).present?

    end

    # 要求管理员
    def require_admin
      if current_admin.blank?

        if wechat_agent?
          redirect_to wechat_path
        else
          redirect_to admin_root_path, alert: "请先登录"
        end
      end
    end

    def require_login
      if !logged_in?
        uri = request.fullpath
        if uri.match(/\/auth\/wechat/)
          session[:return_to] = nil
        else
          session[:return_to] = uri
        end
        if wechat_agent?
          redirect_to '/auth/wechat'
        else
          flash[:alert] = "请先登录"
          redirect_to admin_root_path
        end
      end
    end

    def redirect_back_or_default(default)
      redirect_to(session["return_to"] || request.env["HTTP_REFERER"] || default)
      session["return_to"] = nil
    end

end
