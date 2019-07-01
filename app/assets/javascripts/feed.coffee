# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $(".HeartAnimation").on "click", (event) ->
    $(this).toggleClass "animate"

  $(".photo-mode").click ->
    console.log("photo")
    if $(".feed-photo").hasClass('d-none')
      $(".feed-photo").toggleClass('d-none')
      $(".feed-album").toggleClass('d-none')


  $(".album-mode").click ->
    console.log("album")
    if $(".feed-album").hasClass('d-none')
      $(".feed-photo").toggleClass('d-none')
      $(".feed-album").toggleClass('d-none')

  $(".img-above-2").hover ->
    $(this).toggleClass('album-animation-0')
    $(this).siblings(".img-above-1").toggleClass('album-animation-1')
    true