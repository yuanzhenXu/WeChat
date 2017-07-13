class Wechat::WelcomeController < Wechat::BaseController

  def index
    redirect_to 'index'

  end

  def create
    auth_hash = request.env['omniauth.auth']
    # p ' ** ' * 20
    # p auth_hash
    # openid = auth_hash.fetch('extra').fetch('raw_info').fetch('openid')
    @info = auth_hash.fetch('extra').fetch('raw_info').fetch('openid')
    # if User.exists?
    if User.exists?(openid: [auth_hash.fetch('extra').fetch('raw_info').fetch('openid')])
      @user = User.find_by(openid: [auth_hash.fetch('extra').fetch('raw_info').fetch('openid')])
      session[:user_id] = @user.id
      # @user = User.find_by(openid: session[:user_id])
      # @user = current_user
      p "******#{@info}"
      p "XXXXXXXXX"
      p @user
    else
      @user = User.new
      @user.openid = auth_hash.fetch('extra').fetch('raw_info').fetch('openid')
      @user.nickname = auth_hash.fetch('info').fetch('nickname')
      @user.headimageurl = auth_hash.fetch('extra').fetch('raw_info').fetch('headimgurl')
      session[:user_id] = @user.id
      @user.save!
      # @user = current_user
      # p "pPpppppppppppp"
      # p @user.openid
      # p "AAAAAAAAAA"
      # p current_user
    end
    # render json: @user
    redirect_to wechat_home_path
  end

end
