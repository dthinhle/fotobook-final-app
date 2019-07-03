# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $(".btn-photo").click ->
    $(this).removeClass('text-secondary')
    $(this).addClass('text-primary')
    $(".btn-album").removeClass('text-primary')
    $(".btn-album").addClass('text-secondary')
    if $(".photo-collection").hasClass("d-none")
      $(".photo-collection").removeClass("d-none")
    $(".album-collection").addClass("d-none")

  $(".btn-album").click ->
    $(this).removeClass('text-secondary')
    $(this).addClass('text-primary')
    $(".btn-photo").removeClass('text-primary')
    $(".btn-photo").addClass('text-secondary')
    if $(".album-collection").hasClass("d-none")
      $(".album-collection").removeClass("d-none")
    $(".photo-collection").addClass("d-none")

  # Ajax script

  # $("#follow").click ->
  #   Rails.ajax
  #     type: "GET"
  #     url: "/myprofile"
  #     data: "{
  #       current_user: 'current'
  #     }"
  #     dataType: 'html'
  #     success: () ->
  #       console.log("ajax success")
  #     error: () ->
  #       console.log("ajax error")

  #   followee_id = window.location.pathname.match(/\d+$/)
  #   mydata = 'follow[id]=' + followee_id.to_s
  #   Rails.ajax
  #     type: "POST"
  #     url: "/follows"
  #     data: 'follow[id]=9'
  #     dataType: 'script'
  #     success: () ->
  #       console.log("ajax success")
  #     error: () ->
  #       console.log("ajax error")
  #   console.log("end ajax")