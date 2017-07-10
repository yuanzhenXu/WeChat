class ApplicationController < ActionController::Base

  layout 'admin'
  # before_action :require_admin
  wechat_api
  protect_from_forgery with: :exception
  include SessionsHelper

end
