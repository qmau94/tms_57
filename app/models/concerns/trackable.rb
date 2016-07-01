module Trackable
  extend ActiveSupport::Concern
  def track_activity action, user
    Activity.create user: user, action: action, trackable: self
  end
end
