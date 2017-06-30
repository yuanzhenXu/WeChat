class SessionsController < ApplicationController
  def create
    @user = fetch_user(auth_hash)
    login_in @user

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
