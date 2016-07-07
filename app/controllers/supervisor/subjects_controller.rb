class Supervisor::SubjectsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_supervisor
  before_action :find_subject, except: [:index, :new, :create] 
  
  def new
    @subject = Subject.new
    Settings.default_number_of_tasks.times {@task = @subject.tasks.build}
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "subjects.created"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
  end

  def index
    @subjects = Subject.all
  end
  
  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "subjects.edit_success"
      redirect_to supervisor_subject_path @subject
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "flash.subject_deleted"
    else
      flash[:danger] = t "flash.subject_empty"
    end
    redirect_to supervisor_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description,
      tasks_attributes: [:id, :name, :description, :_destroy]
  end

  def find_subject
    @subject = Subject.find_by id: params[:id]
    unless @subject.present?
      flash[:danger] = t "flash.subject_empty"
      redirect_to root_url
    end
  end
end
