class SessionsController < ApplicationController
  # skip_before_action :require_admin

  wechat_api
  def new
    if current_admin.present?
      redirect_to users_path and return
    end

    if wechat_agent?
      @wechat_login_url = '/auth/wechat'
    end

  end

  def create
    user = User.find_by(mobile: params[:session][:mobile])
    if user
      log_in user
      login_in_as_admin user
      flash[:success] = '登录成功'
      redirect_to user
    else
      flash[:alert] = '账号密码有误， 请重试'
      render 'new'
    end
  end

  # def create
  #   @user = fetch_user(auth_hash)
  #   log_in @user
  #   redirect_to session[:return_to] || wechat_path
  #
  # end

  def destroy
    log_out_admin
    log_out
    flash[:success] = '成功退出'
    redirect_to login_path
  end

  # def auth_callback
  #   @title = '微信登录，结果页'
  #   auth_hash = request.env['omniauth.auth']
  #   @info = auth_hash
  #
  #   openid = auth_hash.fetch('extra').fetch('raw_info').fetch("openid") rescue ''
  #   user_info = auth_hash.fetch('extra').fetch('raw_info').fetch("nickname") rescue ''
  #   render json: @info
  #
  #   # redirect_to "http://fwhjsz.natappfree.cc/auth/wechat"
  # end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end

  def fetch_user(_hash)
    openid = _hash['extra']['raw_info']['openid']
    user = User.find_or_initilize_via_wechat(openid)
    user.attribute = {
        nickename: _hash['extra']['raw_info']['nickname'],
        headimageurl: _hash['extra']['raw_info']['headimgurl']
    }
  end
end
