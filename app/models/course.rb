class Course < ActiveRecord::Base
  after_update :create_user_subject, unless: :check_status

  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects

  validates :name, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :subjects

  enum status: {init: 0, start: 1, finish: 2}
  
  private
  def create_user_subject
    self.user_courses.each do |user_course|
      self.course_subjects.each do |course_subject|
        UserSubject.create user_id: user_course.user_id,
          subject_id: course_subject.subject_id,
          user_course_id: user_course.id
      end
    end
  end

  def check_status
    !self.start?
  end
end
