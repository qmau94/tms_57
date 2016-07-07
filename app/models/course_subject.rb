class CourseSubject < ActiveRecord::Base
  include Trackable
  before_destroy :delete_all_activities
  
  after_update :active_activity, if: :status_change?
  after_update :update_subjects_status

  belongs_to :course
  belongs_to :subject

  enum status: {init: 0, start: 1, finish: 2}

  def update_subjects_status 
    status = self.status
    user_subjects = UserSubject.where course_id: self.course_id,
      subject_id: self.subject_id
    user_subjects.each do |subject|
      subject.update_attributes status: status
    end
  end
end
