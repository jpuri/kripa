class UsersController < ApplicationController

  def appUsers
    @users = User.all
    render :json => @users.collect { |user| {:id => user.id, :username => user.username, :role => user.role} }
  end

  def new
    @user = User.new
  end

  def create
    puts 'me here ..................................in creATE'
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    puts 'me here ..................................'
    puts params[:user].inspect
    @user = User.find(params[:id])

      if @user.update_attributes(params[:user])
        render :json => {:status => 'SUCCESS'}
      else
        render :json => {:status => 'FAILURE'}
      end
  end
end
