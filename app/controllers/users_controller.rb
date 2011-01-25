class UsersController < ApplicationController


  before_filter :authenticate, :only => [:edit, :update]
  
  def show
    @user = User.find(params[:id]) 
    @title = @user.name
  end
  
  def new
    @user  = User.new
    @title = "Sign Up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Updated successfully."
      redirect_to @user
    else  
      @title = "Edit user"
      render 'edit'
    end
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end
    
    def deny_access
      flash[:notice] = "Please sign in to access this page"
      redirect_to signin_path
    end
  
end
