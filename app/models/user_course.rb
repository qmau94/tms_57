class UserCourse < ActiveRecord::Base
  include Trackable

  after_create :add_activity
  before_destroy :remove_activity

  belongs_to :user
  belongs_to :course
  
  has_many :user_subjects, dependent: :destroy
  
  private
  def add_activity
    type = Settings.add_trainee
    self.course.track_activity type, self.user 
  end
  def remove_activity
    type = Settings.remove_trainee
    self.course.track_activity type, self.user
  end
end
