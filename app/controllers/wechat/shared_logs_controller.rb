class Wechat::SharedLogsController < Wechat::BaseController
  def create
    shared_log = SharedLog.create(user_id: params[:user_id], uri: params[:uri], query: params[:query])
    render json: { result: true }
  end
end
