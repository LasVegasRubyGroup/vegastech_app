class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :current_user_is_admin?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    @current_user
  end

  def current_user_is_admin?
    return false if current_user.nil? || !current_user.admin?
    true
  end
end
