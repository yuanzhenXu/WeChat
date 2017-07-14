class Wechat::SessionsController < Wechat::BaseController

  def create
    p ' **' * 20
    auth_hash = request.env['omniauth.auth']
    p auth_hash
    openid = auth_hash.fetch('extra').fetch('raw_info').fetch('openid')
    @user = User.find_or_initilize_via_wechat(openid)
    @user.attributes = {
        nickname: auth_hash.fetch('info').fetch('nickname'),
        headimagurl: auth_hash.fetch('extra').fetch('raw_info').fetch('headimgurl')
    }

    @user.save!
    session[:user_id] = @user.id
    p 'zzzzzz#'+ @user.id
    begin
      @user = fetch_user
      p @user.id+ "我们啊啊啊啊"
      log_in @user
      login_in_as_admin @user if @user.admin?
    rescue => e
      logger.info e.inspect
    end

    redirect_to session[:return_to] || wechat_home_path
  end

  def failure
    flash[:notice] = params[:message]
    render text: params[:message]
  end

  def destroy
    log_out
    log_out_admin

    render plain: 'ok'
  end


  def fetch_user
    auth_hash = request.env['omniauth.auth']
    openid = auth_hash.fetch('extra').fetch('raw_info').fetch('openid')
    user = User.find_or_initilize_via_wechat(openid)
    user.attributes = {
        nickname: auth_hash.fetch('info').fetch('nickname'),
        headimagurl: auth_hash.fetch('extra').fetch('raw_info').fetch('headimgurl')
    }

    user.save!
    session[:user_id] = user.id
    p 'zzzzzz#'+ user.id

    return user

  end

end
