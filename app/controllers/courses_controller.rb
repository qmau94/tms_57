class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
    @user_courses = current_user.user_courses
  end

  def show
    @user_course = UserCourse.includes(course: :user_courses)
      .find_by id: params[:id]
    @course = @user_course.course
    @user_courses = UserCourse.includes(course: :user_courses)
      .where course_id: @course
    if @user_course.nil?
      flash[:danger] = t "courses.empty"
      redirect_to root_url
    else
      @course = @user_course.course
      @user_subjects = @user_course.user_subjects
    end
  end
end
