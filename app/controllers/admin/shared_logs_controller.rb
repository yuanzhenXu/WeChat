class Admin::SharedLogsController < Admin::BaseController

  # wechat_api

  def create
    @shared_log = SharedLog.create(user_id: params[:user_id], query: params[:query], uri: params[:uri])

    render json: { result: true }
  end

  def index
    if params[:id]
      @user = User.find(params[:id])
      @shared_logs = @user.shared_logs
    else
      @shared_logs = SharedLog.includes(:user)
      # if @user_name = params[:user_name].presence
      #   @shared_logs = @shared_logs.joins(:user).where()
      # end

    end
    @shared_logs = @shared_logs.order('created_at desc').page(params[:page]).per(20)
  end
end
