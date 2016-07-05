class UserSubject < ActiveRecord::Base
  include Trackable
  
  after_update :start_activity, if: :init_to_start?
  after_update :finish_activity, if: :start_to_finish?

  belongs_to :user
  belongs_to :subject
  belongs_to :user_course
  belongs_to :course
  
  has_many :user_tasks, dependent: :destroy

  accepts_nested_attributes_for :user_tasks, reject_if: :reject_user_subject,
    allow_destroy: true
  
  enum status: {init: 0, start: 1, finish: 2}

  def reject_user_subject attribute
    attribute[:user_subject_id].blank?
  end

  def ratio
    100 * self.user_tasks.count / self.subject.tasks.count
  end
  
  private
  def start_activity
    type = Settings.started
    self.track_activity type, self.user
  end

  def finish_activity
    type = Settings.finished
    self.track_activity type, self.user
  end
end
