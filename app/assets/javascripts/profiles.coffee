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