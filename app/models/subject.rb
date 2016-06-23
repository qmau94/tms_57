class Subject < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_subjects

  validates :name, presence: true
  validates :description, presence: true
  accepts_nested_attributes_for :tasks, allow_destroy: true,
    reject_if: :reject_tasks

  def reject_tasks attributes
    attributes["name"].blank? || attributes["description"].blank?
  end
end
