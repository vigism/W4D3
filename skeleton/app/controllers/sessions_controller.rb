class SessionsController < ApplicationController

  before_action :redirect, except: [:destroy]

  def redirect
    if logged_in?
      redirect_to cats_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:users][:user_name],params[:users][:password])
    if @user
      login!(@user)
      redirect_to cats_url
      
    else
      @user = User.new
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    end
  end

  def destroy
    @user = current_user
    if @user  
      @user.reset_session_token!
      session[:session_token] = nil
    end
    render :new
  end
  

end
