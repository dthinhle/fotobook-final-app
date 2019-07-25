class Notification < ApplicationRecord

  after_create_commit { NotificationBroadcastJob.perform_later(self)}

  scope :unread_notifications, -> { where read: false }

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

  def message
    event = self.event
    name = User.find(self.params[0]).name
    if event == 'follow'
      return "#{name} follows you"
    else
      if self.params[2] == 0
        item = Photo.find(self.params[1]).title
      else
        item = Album.find(self.params[1]).title
      end

      if event == 'like'
        return "#{self.params[0]} likes your post #{self.params[1]}"
      else event == 'newpost'
        return "#{name} posts a new photo"
      end
    end
  end
end
