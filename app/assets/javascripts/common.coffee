
$(document).on "turbolinks:load", ->
  $(".toast").toast('show')

  $("#dropdown-noti").click ->
    Rails.ajax
      type: "POST"
      url: "/seen"
