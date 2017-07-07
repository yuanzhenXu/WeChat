class ApplicationController < ActionController::Base

  layout 'admin'
  wechat_api
  protect_from_forgery with: :exception
  include SessionsHelper

end
