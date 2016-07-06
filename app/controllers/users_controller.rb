class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user_courses = current_user.user_courses
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, 
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user.present?
      flash[:danger] = t "flash.empty"
      redirect_to root_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
