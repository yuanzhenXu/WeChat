class WechatTagController < ApplicationController

  def create
    @wechat_tag = WechatTag.create(wechat_tag_params)
  end

  def edit
    @wechat_tag = WechatTag.find(params[:id])
    @wechat_tag.update(wechat_tag_params)
    @wechat_tag.save
  end

  def delete
    @wechat_tag = WechatTag.find(params[:id])
    @wechat_tag.destroy
  end

  private
  def wechat_tag_params
    params.require(:wechat_tag).permit(:name)
  end

end
