class Admin::UsersController < Admin::BaseController

    # wechat_api

    def new
      @user = User.new
    end

    def index
      @users = User.all

      if @is_admin = params[:is_admin].presence
        if
        @is_admin == 'on'
          @users = @users.admin
        elsif @is_admin == 'off'
          @users = @users.not_admin
        end
      end
      @users = @users.order('created_at desc').page(params[:page]).per(20)
    end

    def show
      # @user = User.find(params[:id])
      @user = @current_user
      # @wechat_tags = @user.wechat_tags.find_by(params[:id])
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
      # @user.wechat_tags = wechat_tags
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "更新成功"
        redirect_to  admin_users_path
        # render plain: 'ok'
      else
        render 'edit'
      end

    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to admin_users_url
    end

    def login_as
      log_in @user
      if wechat_agent?
        redirect_to wechat_home_path
      else
        redirect_to root_path
      end
    end

    private
    def user_params
      params.require(:user).permit(:nickname, :password_digest, :email, :wechat_tags)
    end

end



