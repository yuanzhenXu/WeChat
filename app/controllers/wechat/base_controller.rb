class Wechat::BaseController < ApplicationController
  wechat_api
  layout 'wechat'
  before_action :require_login
  before_action :save_view_log

  def save_view_log
    return if params[:shared_user_id].blank? || !logged_in?
    shared_user_id = params[:shared_user_id]
    return if current_user.id = shared_user_id.to_i
    uri = request.fullpath.split('?').first
    # ViewLog.create(
    #     shared_user_id: shared_user_id,
    #     viewer_id: current_user.id,
    #     uri: uri
    # )
  end

end
