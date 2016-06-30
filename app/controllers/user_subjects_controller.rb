class UserSubjectsController < ApplicationController
  before_action :logged_in_user, :find_user_subject,
    :get_user_task, only: [:show, :update]
  
  def show
  end

  def update
    if @user_subject.update_attributes user_subject_params
      flash[:success] = t "update.success"
    else
      flash[:danger] = t "update.fail"
    end
    redirect_to course_user_subject_path @user_course, @user_subject
  end

  private
  def find_user_subject
    @user_subject = current_user.user_subjects.find_by id: params[:id]
    if @user_subject.nil?
      flash[:danger] = t "subjects.empty"
      redirect_to root_url
    else
      @user_course = @user_subject.user_course
      @subject = @user_subject.subject
      @tasks = @user_subject.subject.tasks
      @user_tasks = current_user.user_tasks
    end  	
  end

  def user_subject_params
    params.require(:user_subject).permit :user_id, :user_course_id,
      :subject_id, user_tasks_attributes: [:user_subject_id, :user_id, :task_id]
  end

  def get_user_task
    @user_task = UserTask.new
  end
end
