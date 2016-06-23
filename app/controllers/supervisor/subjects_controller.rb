class Supervisor::SubjectsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new, :index]
  before_action :verify_supervisor, only: [:create, :new, :index]

  def new
    @subject = Subject.new
    Settings.default_number_of_tasks.times {@subject.tasks.build}
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

  private
  def subject_params
    params.require(:subject).permit :name, :description,
      tasks_attributes: [:id, :name, :description, :_destroy]
  end
end
