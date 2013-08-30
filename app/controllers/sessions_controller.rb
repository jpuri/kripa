class SessionsController < ApplicationController

  def new
  end

  def show
    user_id = session[:user_id] 
    if user_id
    user = User.find(user_id)
    end
    if user
      render :json => {:status => 'SUCCESS', :username => user.username, :role => user.role}
    else
      render :json => {:status => 'FAILURE', :message => "Invalid username or password"}
    end
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      render :json => {:status => 'SUCCESS', :username => user.username, :role => user.role}
    else
      render :json => {:status => 'FAILURE', :message => "Invalid username or password"}
    end
  end

  def destroy
    session[:user_id] = nil
    render :json => {:status => 'SUCCESS'}
  end
  
end

#REFACTORED