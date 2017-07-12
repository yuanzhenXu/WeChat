class Admin::SessionsController < Admin::BaseController

  skip_before_action :require_admin

  def new
    if current_admin.present?
      redirect_to admin_users_path and return
    end

    if wechat_agent?
      @wechat_login_url = '/auth/wechat'
    else
      # @wechat_login_url = qr_login_uri
    end
  end

  def create
    user = User.admin.find_by(mobile: params[:session][:mobile].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      login_in_as_admin user
      flash[:success] = '登录成功'
      redirect_to admin_users_path
    else
      flash[:alert] = '账号或密码有误，请重试'
      render 'new'
    end
  end
end
