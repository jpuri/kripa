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
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
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