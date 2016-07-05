class Supervisor::ActiveSubjectsController < ApplicationController
  before_action :logged_in_user, :verify_supervisor, :verify_actived_course,
    only: :update
   
  def update
    @subject = CourseSubject.find_by id: params[:course_subject_id]
    if @subject.update_attributes status: active_params
      flash[:success] = t "flash.subject_started"
    else
      flash[:danger] = t "flash.subject_failed"
    end
    redirect_to :back
  end

  private
  def active_params
    params[:status]
  end

  def verify_actived_course
    @course = Course.find_by id: params[:course_id]
    unless @course.start?
      flash[:danger] = t "flash.course_not_actived"
      redirect_to [:supervisor, @course]
    end
  end
end
