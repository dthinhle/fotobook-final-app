class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    user = notification.user_id
    counter = User.find(user).notifications.size
    ActionCable.server.broadcast 'notification_channel', counter: counter, notification: render_notification(notification)
  end

  private

  def render_notification(notification)
    ApplicationController.renderer.render(partial: 'notifications/notification_post', locals: { noti: notification })
  end

end
