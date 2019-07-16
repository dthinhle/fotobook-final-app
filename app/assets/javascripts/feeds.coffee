# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $(".content-field").on "click", ".heart-animation", (event) ->
    if $(this).attr("data-guest") == "false"
      heartBtn = $(this)
      if $(heartBtn).hasClass("heart-on")
        $(this).removeClass "animate"
        $(this).removeClass "heart-on"

        mode = heartBtn.attr("data-mode")
        id = heartBtn.attr("data-id")

        heartBtn.next().text(parseInt(heartBtn.next().text()) - 1)

        Rails.ajax
          type: "POST"
          url: "/"+mode+"s/"+id+"/unlike"
          dataType: 'script'
          success: () ->
            false
      else
        $(this).addClass "animate"
        setTimeout ->
          heartBtn.addClass "heart-on"
        , 1

        mode = heartBtn.attr("data-mode")
        id = heartBtn.attr("data-id")

        heartBtn.next().text(parseInt(heartBtn.next().text()) + 1)

        Rails.ajax
          type: "POST"
          url: "/"+mode+"s/"+id+"/like"
          dataType: 'script'
          success: () ->
            false


  $(".photo-mode").click ->
    site = $(this).children().attr("data-site")
    Rails.ajax
      type: "GET"
      url: "/"+site
      data: "request[mode]=photos"
      dataType: 'script'
      success: () ->
        false


  $(".album-mode").click ->
    site = $(this).children().attr("data-site")
    Rails.ajax
      type: "GET"
      url: "/"+site
      data: "request[mode]=albums"
      dataType: 'script'
      success: () ->
        false

  $(".content-field").on "click",".img-photo",->
    id = $(this).attr("data-id")
    Rails.ajax
      type: "GET"
      url: "/photopreview"
      data: "request[param]="+id.toString()
      dataType: 'script'
      success: () ->
        $("#imgPreviewModal").modal('show')
        false

  $(".content-field").on "mouseenter",".img-above-2", ->
    $(this).toggleClass('album-animation-0')
    $(this).siblings(".img-above-1").toggleClass('album-animation-1')
    true

  $(".content-field").on "mouseleave",".img-above-2", ->
    $(this).toggleClass('album-animation-0')
    $(this).siblings(".img-above-1").toggleClass('album-animation-1')
    true

  $(".content-field").on "click",".img-above-2", ->
    id = $(this).attr("data-id")
    Rails.ajax
      type: "GET"
      url: "/albumpreview"
      data: "request[param]="+id.toString()
      dataType : 'script'
      success: () ->
        $("#imgPreviewModal").modal('show')
        false
