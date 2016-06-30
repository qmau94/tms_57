class UserSubject < ActiveRecord::Base
  include Trackable
  
  belongs_to :user
  belongs_to :subject
  belongs_to :user_course
  
  has_many :user_tasks, dependent: :destroy

  accepts_nested_attributes_for :user_tasks, reject_if: :reject_user_subject,
    allow_destroy: true
  
  enum status: {init: 0, start: 1, finish: 2}

  def reject_user_subject attribute
    attribute[:user_subject_id].blank?
  end
end
