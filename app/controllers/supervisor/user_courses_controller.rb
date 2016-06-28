class Supervisor::UserCoursesController < ApplicationController
  before_action :verify_supervisor

  def destroy
    user_course = UserCourse.find_by course_id: params[:id]
    course_id = user_course.course_id
    if user_course.destroy
      flash[:success] =  t "flash.removed_user"    
    else
      flash.now[:danger] = t "flash.remove_user_failed"
    end
    redirect_to supervisor_course_path course_id
  end
end
