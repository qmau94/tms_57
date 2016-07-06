class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
    @user_courses = current_user.user_courses
  end

  def show
    @user_course = UserCourse.includes(course: :user_courses)
      .find_by id: params[:id]
    @course = @user_course.course
    @user_courses = @course.user_courses
    @activities = @user_course.course.all_activities
    if @user_course.nil?
      flash[:danger] = t "courses.empty"
      redirect_to root_url
    else
      @course = @user_course.course
      @user_subjects = @user_course.user_subjects
    end
  end
end
