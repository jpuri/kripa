class UsersController < ApplicationController

  def index
    @users = User.all
  end

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
      redirect_to root_url
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    puts '========================================================='
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Bill was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end
end
