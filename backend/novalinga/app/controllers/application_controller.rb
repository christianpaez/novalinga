class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    include ::ActionController::Cookies
    include ApplicationHelper
    protect_from_forgery with: :null_session

    before_action :authenticate_admin!, :if => :html_request?
end
