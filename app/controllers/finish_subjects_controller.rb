class FinishSubjectsController < ApplicationController
  before_action :logged_in_user, :verify_started_course, only: :update
   
  def update
    if @user_subject.update_attributes status: active_params
      flash[:success] = t "flash.subject_updated"
    else
      flash[:danger] = t "flash.subject_failed"
    end
    redirect_to [@user_subject.course, @user_subject]
  end

  private
  def active_params
    params[:status]
  end
  
  def verify_started_course
    @user_subject = current_user.user_subjects.find_by id: params[:user_subject_id]
    unless @user_subject.start?
      flash[:danger] = t "subjects.is_not_started"
    end
  end
end
