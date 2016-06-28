class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
    @user_courses = current_user.user_courses
  end

  def show
    @user_course = current_user.user_courses.find_by id: params[:id]
    if @user_course.nil?
      flash[:danger] = t "courses.empty"
      redirect_to root_url
    else
      @course = @user_course.course
      @user_subjects = @user_course.user_subjects
    end
  end
end
