class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      puts '====================================success'
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      puts '====================================failed'
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
end