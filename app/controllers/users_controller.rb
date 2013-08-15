class UsersController < ApplicationController

  def index
    @users = User.all
    render :json => @users.collect { |user| {:id => user.id, :username => user.username, :role => user.role} }
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
    error_messages = Array.new
    
    if(params[:changePassword])
      if !params[:user][:password]
        error_messages << 'Password can not be null.'
      else 
        if (params[:user][:password] != params[:user][:password_confirmation])
          error_messages << 'Password do not match.'
        end
      end
    end

    @user = User.find(params[:id])
    if !@user.update_attributes(params[:user])
      @user.errors.each do |attr,message|
        error_messages << message
      end
    end

    if error_messages.length == 0
      render :json => {:status => 'SUCCESS'}
    else
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

#REFACTORED