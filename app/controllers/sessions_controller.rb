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

  protected
  def auth_hash
    request.env['omniauth.auth']
  end


  def fetch_user(_hash)
    openid = _hash['openid']
    user = User.find_or_initilize_via_wechat(openid)
    user.attribute = {
        nickename: _hash['nickname'],
        email: _hash['email']
    }

  end
end
