class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  scope :desc, -> {order created_at: :desc}
  scope :find_with, -> trackable{where trackable_type: trackable.class.to_s,
    trackable_id: trackable.id}
end
