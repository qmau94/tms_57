class Subject < ActiveRecord::Base
  include Trackable
  
  before_destroy :delete_all_activities

  has_many :tasks, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_subjects

  validates :name, presence: true
  validates :description, presence: true
  accepts_nested_attributes_for :tasks, allow_destroy: true

  def all_activities
    activities = Array.new
    acts = Activity.all
    activities += acts.find_with self
    activities += acts.find_with_many self.user_tasks
    activities.sort {|a,b| b.created_at <=> a.created_at}
  end
end
