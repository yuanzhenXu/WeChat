class ApplicationController < ActionController::Base

  layout 'admin'
  # before_action :require_admin
  wechat_api
  protect_from_forgery with: :exception
  include SessionsHelper

  def enum_color(_id)
    return '' if _id.blank?
    colors = %W(plain primary info success warning danger)
    colors[_id%6]
  end

end
