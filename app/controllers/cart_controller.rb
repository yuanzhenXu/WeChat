class CartController < ApplicationController
  wechat_api

  # 获取用户的相关信息
  def index
    wechat_oauth2 do |openid|
      @current_user = User.find_by(wechat_openid: openid)
      # @articles = @current_user.articles
    end
  end
end
