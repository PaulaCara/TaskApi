require 'active_resource'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_filter :current_token?
  helper_method :current_token

  private

  def current_token?
    create_token

    # I kept receiving 401 status for PUT /v2/sessions request even if I attached
    # the correct header and parameter.
    #
    # begin
    #   Session.headers['Authorization'] = session[:access_token]
    #   Session.all # GET /v2/sessions
    #
    #   session[:access_token] ? update_token : create_token
    # rescue ActiveResource::ResourceNotFound
    #   flash[:error] = "The pool isn't found"
    #   redirect_to :back
    # end
  end

  def create_token
    puts 'about to create session'
    @session = Session.new(api_key: 'KklyUtXD7NQb8oIYQDMBDw', api_secret: 'password')
    puts 'created session'
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
