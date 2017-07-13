class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  # include ControllerHelpers::Auth
  include SessionsHelper


end
