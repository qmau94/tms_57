module Trackable
  extend ActiveSupport::Concern
  
  def delete_all_activities
    self.all_activities.each do |activity|
      activity.destroy
    end
  end

  def track_activity action, user
    Activity.create user: user, action: action, trackable: self
  end

  private
  def active_activity
    user = nil 
    type = self.start? ? I18n.t("activity.start") : I18n.t("activity.finish")
    self.track_activity type, user 
  end

  def status_change?
    self.status_changed? 
  end

  def init_to_start?
    self.status_changed? from: "init", to: "start"
  end

  def start_to_finish?
    self.status_changed? from: "start", to: "finish"
  end
end
