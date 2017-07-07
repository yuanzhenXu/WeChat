class UsersController < ApplicationController
  wechat_api

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # @user = @current_user
    # @wechat_tag = @user.wechat_tag.find_by(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:ontice] = "注册成功"
      redirect_to @user
    else
      flash[:alert] = "注册失败"
      render 'new'
    end
  end

  # 给用户添加标签
  def edit
    @user = User.find(params[:id])
    # @user.wechat_tag = wechat_tag
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新成功"
      redirect_to  @user
    else
      render 'edit'
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private
  def user_params
    params.require(:user).permit(:nickname, :password_digest, :email, :wechat_tag)
  end
end
