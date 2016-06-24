class Supervisor::CoursesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :verify_supervisor, only: [:new, :create]

  def new
    @course = Course.new
    @subjects = Subject.all
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "courses.created"
      redirect_to root_url
    else
      render :new
    end
  end

  private
  def course_params
    params.require(:course).permit :name, :description, subject_ids: []
  end
end
