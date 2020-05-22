class SessionsController < ApplicationController
  layout false
  def index
  end

  def create
    @auth = request.env['omniauth.auth']['credentials']
  end

  def new
  end
end
