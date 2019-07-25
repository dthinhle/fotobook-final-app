App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    console.log('received data')
    if $(".noti-count").hasClass('d-none')
      $(".noti-count").removeClass('d-none')
    $('#notification-list').prepend "#{data.notification}"
    if $("#notification-list .notification-post").length > 5
      $("#notification-list .notification-post").last().remove()
    $('#notification-count').html data.counter
    # Called when there's incoming data on the websocket for this channel
