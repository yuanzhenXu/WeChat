class Admin::ViewLogsController < Admin::BaseController

  def index
    if params[:user_id]
      @user = User.find_by_id(params[:user_id])
      @view_logs = ViewLog.select('view_logs.*, viewers.nickname as viewer_nickname').joins('join users as viewers on viewers.id = view_logs.viewer_id').where(shared_user_id: @user.id)
    else
      @view_logs = ViewLog.select('view_logs.*, shared_users.nickname as shared_user_nickname, viewers.nickname as viewer_nickname').joins('join users as shared_users on shared_users.id = view_logs.shared_user_id').joins('join users as viewers on viewers.id = view_logs.viewer_id')

      if @shared_user_name = params[:shared_user_name].presence
        @view_logs = @view_logs.where('shared_users.nickname like :name', name: '%' + @shared_user_name+ '%')
      end
    end

    if @viewer_name = params[:viewer_name].presence
      @view_logs = @view_logs.where('viewers.nickname like :name', name: '%' + @viewer_name + '%')
    end

    if @uri = params[:uri].presence
      @view_logs = @view_logs.where('uri like ?', '%'+ @uri + '%')
    end

    @view_logs = @view_logs.order('created_at desc').page(params[:page]).per(20)

  end

end
