class Admin::WechatUsersController < Admin::BaseController

    # wechat_api
    def index
      @wechat_users = WechatUser.all

    end

    def show
      @wechat_user = WechatUser.find(params[:id])
      @wechat_tag = @wechat_user.wechat_tag.find(params[:id])
    end

    def edit
      @wechat_user = WechatUser.find(params[:id])

    end

    def destroy
      @wechat_user = WechatUser.find(params[:id])
      @wechat_user.destroy
      redirect_to wechat_users_path
    end

end
