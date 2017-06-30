class UserController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "注册成功"
      redirect_to root_url
    else
      render 'new'
    end

  end

  def update
    @user.attributes = user_params
    if @user.update_attributes(user_params)
      flash[:notice] = "修改成功"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "删除成功"
    redirect_to users_url
  end

  private
  def user_params
    param.require(:user).permit(:mobile, :nickname, :email)
  end

end
