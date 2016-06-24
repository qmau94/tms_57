class Supervisor::UsersController < ApplicationController
  before_action :logged_in_user, except: :show
  before_action :verify_supervisor
  before_action :find_user, except: [:create, :index, :new]
  before_action :get_role, only: [:new, :edit]

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

  def index
    @trainees = User.trainee.all
    @supervisors = User.supervisor.all
  end

  def edit
  end

  def destroy
    if @user.nil?
      flash[:danger] = t ("flash.user_notexist") 
    else
      @user.destroy
      flash[:success] = t ("flash.deleted_user")
    end
    redirect_to root_path
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.supervisor_edit_user"
      redirect_to supervisor_user_path
    else
      get_role
      render :edit
    end   
  end
  
  def show
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
