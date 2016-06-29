class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :user_course
  
  enum status: {init: 0, start: 1, finish: 2}
end
