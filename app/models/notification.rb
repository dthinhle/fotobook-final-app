class Notification < ApplicationRecord

  after_create_commit { NotificationBroadcastJob.perform_later(self)}

  def time_since
    t_since = Time.zone.now - self.created_at
    if t_since < 60
      "#{t_since.floor} second(s) ago"
    elsif t_since/60 < 60
      "#{(t_since/60).floor} minute(s) ago"
    elsif t_since/3600 < 24
      "#{(t_since/36000).floor} hour(s) ago"
    elsif t_since/86400 < 30
      "#{(t_since/86400).floor} day(s) ago"
    else
      "A long time ago"
    end
  end
end
