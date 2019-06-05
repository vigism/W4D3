class UsersController < ApplicationController

  before_action :redirect

  def redirect
    if logged_in?
      redirect_to cats_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    # render :show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
       flash.now[:errors] = @user.errors.full_messages
      # render :new
      render :new
    end
  end

  private
  def user_params
    params.require(:users).permit(:user_name, :password)
  end
end
