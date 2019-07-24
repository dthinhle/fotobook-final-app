# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $(".content-field").on "click", ".heart-animation", (event) ->
    if $(this).attr("data-guest") == "false"
      heartBtn = $(this)

      mode = heartBtn.attr("data-mode")
      id = heartBtn.attr("data-id")
      if $(heartBtn).hasClass("heart-on")
        $(this).removeClass "animate"
        $(this).removeClass "heart-on"

        heartBtn.next().text(parseInt(heartBtn.next().text()) - 1)

        Rails.ajax
          type: "POST"
          url: "/#{mode}s/#{id}/unlike"
          dataType: 'script'
      else
        $(this).addClass "animate"
        $(this).addClass "heart-on"

        heartBtn.next().text(parseInt(heartBtn.next().text()) + 1)

        Rails.ajax
          type: "POST"
          url: "/#{mode}s/#{id}/like"
          dataType: 'script'


  $(".photo-mode").click ->
    site = $(this).children().attr("data-site")
    Rails.ajax
      type: "GET"
      url: "/#{site}"
      data: "request[mode]=photos"
      dataType: 'script'


  $(".album-mode").click ->
    site = $(this).children().attr("data-site")
    Rails.ajax
      type: "GET"
      url: "/#{site}"
      data: "request[mode]=albums"
      dataType: 'script'

  $(".content-field").on "mouseenter",".img-above-2", ->
    $(this).toggleClass('album-animation-0')
    $(this).siblings(".img-above-1").toggleClass('album-animation-1')
    true

  $(".content-field").on "mouseleave",".img-above-2", ->
    $(this).toggleClass('album-animation-0')
    $(this).siblings(".img-above-1").toggleClass('album-animation-1')
    true