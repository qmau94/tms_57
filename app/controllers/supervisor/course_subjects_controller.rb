class Supervisor::CourseSubjectsController < ApplicationController
  before_action :logged_in_user, :verify_supervisor, only: [:show]

  def show
    @course_subject = CourseSubject.find params[:id]
    @course = @course_subject.course
    @subject = @course_subject.subject
    @activities = Activity.find_with @course_subject
  end
end
