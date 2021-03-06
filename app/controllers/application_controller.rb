require 'active_resource'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_filter :current_token?

  private

  def current_token?
    create_token # this enables the site to work at all times, as the below code is not currently working

    # I kept receiving 401 status for PUT /v2/sessions request even if I attached
    # the correct header and parameter.
    #
    # begin
    #   Session.headers['Authorization'] = session[:access_token]
    #   Session.all # GET /v2/sessions
    #
    # rescue ActiveResource::UnauthorizedAccess
    #   session[:access_token] ? update_token : create_token
    # end
  end

  def create_token
    @session = Session.new(api_key: 'KklyUtXD7NQb8oIYQDMBDw', api_secret: 'password')

    if @session.save
      session[:access_token] = @session.access_token
      session[:refresh_token] = @session.refresh_token
      puts @session.inspect
    else
      flash[:error] = 'You don\'t have the right credentials'
    end
  end

  def update_token
    Session.headers['Authorization'] = session[:access_token]
    @session = Session.new(refresh_token: session[:refresh_token])

    if @session.save
      session[:access_token] = @session.access_token
      session[:refresh_token] = @session.refresh_token
    else
      flash[:error] = 'You don\'t have the right credentials'
    end
  end
end
