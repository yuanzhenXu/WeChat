class Admin::WechatTagsController < Admin::BaseController

    before_action :fetch_tag, only: [:show, :edit, :update, :destroy, :users]

    def index
      @wechat_tags = WechatTag.all.includes(:users).page(params[:page]||1).per(20)
    end

    def show


    end

    def edit

    end

    def new
      @wechat_tag = WechatTag.new
    end

    def create
      @wechat_tag = WechatTag.create(wechat_tag_params)
      if @wechat_tag.save
        flash[:notice] = "保存成功"
        redirect_to admin_wechat_tags_path
      else
        render action: 'new'
      end
    end

    def update
      @wechat_tag = WechatTag.find(params[:id])
      @wechat_tag.update(wechat_tag_params)
      if @wechat_tag.save
        flash[:notice] = "更新成功"
        redirect_to admin_wechat_tags_path
      else
        redirect_to 'edit'
      end
    end

    def destroy
      @wechat_tag = WechatTag.find(params[:id])
      @wechat_tag.destroy
      flash[:notice] = "删除成功"
      redirect_to admin_wechat_tags_path
    end

    def users
      @users = @wechat_tag.users
      render :edit
    end

    private
    def fetch_tag
      @wechat_tag = WechatTag.find(params[:id])
    end

    def wechat_tag_params
      params.require(:wechat_tag).permit(:name, :tag_type)
    end

end
