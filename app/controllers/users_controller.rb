class UsersController < ApplicationController

  def appUsers
    @users = User.all
    render :json => @users.collect { |user| {:id => user.id, :username => user.username, :role => user.role} }
  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(params[:user])
    if @user.save
      render :json => {:status => 'SUCCESS', :user_id => @user.id}
    else
      error_messages = Array.new
      @user.errors.each do |attr,message|
        error_messages << message
      end
      render :json => {:status => 'FAILURE', :messages => error_messages}
    end
  end
  
  def update
    changePassword = params[:changePassword]
    changePasswordFlag = true
    error_messages = Array.new
    puts params[:user][:password]
    if(changePassword)
      if !params[:user][:password]
        changePasswordFlag = false
        error_messages << 'Password can not be null.'
      else 
        if (params[:user][:password] != params[:user][:password_confirmation])
          changePasswordFlag = false
          error_messages << 'Password do not match.'
        end
      end
    end
    @user = User.find(params[:id])
    if changePasswordFlag && @user.update_attributes(params[:user])
      render :json => {:status => 'SUCCESS'}
    else
      @user.errors.each do |attr,message|
        error_messages << message
      end
      render :json => {:status => 'FAILURE', :messages => error_messages}
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.delete
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end
end