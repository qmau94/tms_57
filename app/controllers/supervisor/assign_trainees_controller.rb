class Supervisor::AssignTraineesController < ApplicationController
  before_action :verify_supervisor, only: [:edit, :update]
  before_action :find_course, only: [:edit, :update]

  def edit
    @trainees = User.trainee.avaiable_user @course.id
    @supervisors = User.supervisor
  end

  def update
    if @course.update_attributes user_course_params
      flash[:success] = t "assign_trainees.success"
      redirect_to supervisor_course_path @course
    else
      flash.now[:danger] = t "assign_trainees.fail"
      redirect_to root_path
    end
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
