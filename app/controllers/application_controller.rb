class ApplicationController < ActionController::Base
  
  #protect_from_forgery
  
  helper_method :current_user
  
  def session_timeout
    if params[:action].start_with?('ajax') && current_user == nil
      render :status => 408
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
end
