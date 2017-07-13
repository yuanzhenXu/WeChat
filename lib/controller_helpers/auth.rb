module ControllerHelpers
  module Auth
    extend ActiveSupport::Concern

    included do
      helper_method :current_user, :logged_in?
    end

    def current_user
      return @current_user if @current_user.present?

      @current_user = User.find_by(id: session[:user_id]) if session[:user_id].present?
    end

    def current_user=(user)
      return nil if user.blank?
      session[:user_id] = user.id
      @current_user = user
    end

    def log_in(user)
      session[:user_id] = user.id
    end

    def login_in_as_admin(user)
      session[:admin_id] = user.id
    end

    def logged_in?
      !current_user.nil?
    end

    # Logs out the current user.
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

    def log_out_admin
      session.delete(:admin_id)
      @current_admin = nil
    end

    def wechat_agent?
      user_agent = request.user_agent
      return false if user_agent.blank?

      return /micromessenger/.match(user_agent.downcase).present?
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
          flash[:alert] = t('login_notice')
          redirect_to root_path
        end
      end
    end

    def redirect_back_or_default(default)
      redirect_to(session["return_to"] || request.env["HTTP_REFERER"] || default)
      session["return_to"] = nil
    end
  end
end