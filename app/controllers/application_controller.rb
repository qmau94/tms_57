class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  def verify_started_course
    @user_subject = current_user.user_subjects.find_by id: params[:user_subject_id]
    if @user_subject
      unless @user_subject.start?
        flash[:danger] = t "subjects.is_not_started"
      end
    else
      flash[:danger] = t "flash.subject_empty"
    end
  end
  
  def verify_editable_course
    @course = Course.find_by id: params[:id]
    if @course.start?
      flash[:danger] = t "courses.cannot_edit"
      redirect_to :back
    end
  end
end
