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
end
