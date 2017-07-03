class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&&user.authenticate(params[:session][:password_digest])
      log_in user
      redirect_to user
    else
      render 'new'
    end
  end

  # def create
  #   @user = fetch_user(auth_hash)
  #   login_in @user
  #
  # end

  def destroy
    log_out
    redirect_to root_url
  end

  def auth_callback
    @title = '微信登录，结果页'
    auth_hash = request.env['omniauth.auth']
    @info = auth_hash

    openid = auth_hash.fetch('extra').fetch('raw_info').fetch("openid") rescue ''
    user_info = auth_hash.fetch('extra').fetch('raw_info')

    redirect_to "http://yourserver"
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end

  def fetch_user(_hash)
    openid = _hash['extra']['raw_info']['openid']
    user = User.find_or_initilize_via_wechat(openid)
    user.attribute = {
        nickename: _hash['extra']['raw_info']['nickname'],
        headimageurl: _hash['extra']['raw_info']['headimageurl']
    }
  end
end
