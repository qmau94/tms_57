class Supervisor::ActiveCoursesController < ApplicationController
  before_action :logged_in_user, :verify_supervisor, :find_course,
    only: :update

  def update
    if @course.update_attributes status: active_params
      flash[:success] = t "flash.course_updated"
    else
      flash[:danger] = t "flash.course_updated_fail"
    end
    redirect_to [:supervisor, @course]
  end

  private
  def active_params
    params[:status]
  end

  def find_course
    @course = Course.find_by id: params[:course_id]
    if @course.nil?
      flash[:danger] = t "courses.empty"
      redirect_to root_url
    end
  end
end
