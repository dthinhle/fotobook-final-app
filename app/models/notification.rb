class Notification < ApplicationRecord

  after_create_commit { NotificationBroadcastJob.perform_later(self)}

  scope :unread_notifications, -> { where read: false }

  def time_since
    t_since = Time.zone.now - self.created_at
    if t_since < 60
      I18n.translate('seconds-ago', count: t_since.floor )
      # "#{t_since.floor} second(s) ago"
    elsif t_since/60 < 60
      I18n.translate('minutes-ago', count: (t_since/60).floor )
    elsif t_since/3600 < 24
      I18n.translate('hours-ago', count: (t_since/3600).floor)
    elsif t_since/86400 < 30
      I18n.translate('days-ago', count: (t_since/86400).floor)
    else
      "A long time ago"
    end
  end

  def image
    if event == 'follow'
      user = User.find(self.params[0])
      return user.avt_url
    else
      if self.params[2] == 0
        return Photo.find(self.params[1]).img.thumb.url
      else
        return Album.find(self.params[1]).photos[0].img.thumb.url
      end
    end
  end

  def message
    event = self.event
    name = User.find(self.params[0]).name
    if event == 'follow'
      return "#{name} follows you"
    else
      if self.params[2] == 0
        item = "photo #{Photo.find(self.params[1]).title}"
      else
        item = "album #{Album.find(self.params[1]).title}"
      end

      if event == 'like'
        return "#{name} likes your #{item}"
      else event == 'newpost'
        return "#{name} posts a new #{item}"
      end
    end
  end
end
