class Supervisor::AssignTraineesController < ApplicationController
  before_action :verify_supervisor, only: [:edit, :update]
  before_action :find_course, only: [:edit, :update]

  def edit
    @users = User.trainee.avaiable_user @course.id
  end

  def update
    if @course.update_attributes user_course_params
      flash[:success] = t "assign_trainees.success"
    else
      flash.now[:danger] = t "assign_trainees.fail"
    end
    redirect_to root_path
  end

  private
  def user_course_params
    params.require(:course).permit user_ids: []
  end

  def find_course
    @course = Course.find_by id: params[:id]  	
    if @course.nil?
      flash[:danger] = t "flash.course_empty"
      redirect_to root_path           	
    end
  end
  
end
