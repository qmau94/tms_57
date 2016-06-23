class Supervisor::UsersController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]
  before_action :verify_supervisor, only: [:create, :new]
  before_action :get_role, only: [:new]

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.user_created"
      redirect_to root_path
    else
      get_role
      render :new
    end
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :role, :password, 
      :password_confirmation
  end

  def get_role
    @role = User.roles    
  end
end
