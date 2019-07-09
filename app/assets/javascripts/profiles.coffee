# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $(".btn-photo").click ->
    $(".menu a").removeClass('text-primary')
    $(this).addClass('text-primary')

    id = $(".myprofile-avatar").attr('data-id')
    Rails.ajax
      type: "GET"
      url: "/getphotos"
      data: "data[param]="+id.toString()+"&data[mode]=photos"
      dataType: 'script'
      success: () ->
        false

  $(".btn-album").click ->
    $(".menu a").removeClass('text-primary')
    $(this).addClass('text-primary')

    id = $(".myprofile-avatar").attr('data-id')
    Rails.ajax
      type: "GET"
      url: "/getphotos"
      data: "data[param]="+id.toString()+"&data[mode]=albums"
      dataType: 'script'
      success: () ->
        false

  $(".btn-follower").click ->
    $(".menu a").removeClass('text-primary')
    $(this).addClass('text-primary')

    id = $(".myprofile-avatar").attr('data-id')
    Rails.ajax
      type: "GET"
      url: "/getfollows"
      data: "data[param]="+id.toString()+"&data[mode]=followers"
      dataType: 'script'
      success: () ->
        false

  $(".btn-followee").click ->
    $(".menu a").removeClass('text-primary')
    $(this).addClass('text-primary')

    id = $(".myprofile-avatar").attr('data-id')
    Rails.ajax
      type: "GET"
      url: "/getfollows"
      data: "data[param]="+id.toString()+"&data[mode]=followees"
      dataType: 'script'
      success: () ->
        false

  $("#editprofile").click ->
     window.location.href = "/editprofile"

  $(".button-container").on "click","#follow", ->
    followee_id = $(this).attr("data-id")
    console.log(followee_id)
    $(this).text("Unfollow")
    $(this).addClass("active")
    $(this).attr("id","unfollow")
    Rails.ajax
      type: "POST"
      url: "/follows"
      data: "follow[followee]="+followee_id.toString()
      dataType: 'json'
      success: () ->
        false

  $(".button-container").on "click","#unfollow", ->
    followee_id = $(this).attr("data-id")
    $(this).text("Follow")
    $(this).removeClass("active")
    $(this).attr("id","follow")
    Rails.ajax
      type: "DELETE"
      url: "/follows/"+followee_id.toString()
      data: "follow[id]="+followee_id.toString()
      dataType: 'json'
      success: () ->
        false

  $(".collection").on "click", ".lock", ->
    $(this).addClass("bg-danger")
    $(this).addClass("unlock")
    $(this).removeClass("lock")
    id = $(this).next().children().attr("data-id")

    Rails.ajax
      type: "POST"
      url: "/task"
      data: "request[task]=lock&request[param]="+id.toString()
      dataType: 'json'
      success: () ->
        false

  $(".collection").on "click", ".unlock", ->
    $(this).removeClass("bg-danger")
    $(this).addClass("lock")
    $(this).removeClass("unlock")
    id = $(this).next().children().attr("data-id")

    Rails.ajax
      type: "POST"
      url: "/task"
      data: "request[task]=unlock&request[param]="+id.toString()
      dataType: 'json'
      success: () ->
        false

  $(".collection").on "click",".img-fit",->
    id = $(this).attr("data-id")
    Rails.ajax
      type: "GET"
      url: "/photopreview"
      data: "request[param]="+id.toString()
      dataType: 'script'
      success: () ->
        $("#imgPreviewModal").modal('show')
        false


  $(".collection").on "click",".img-above-2", ->
    id = $(this).attr("data-id")
    Rails.ajax
      type: "GET"
      url: "/albumpreview"
      data: "request[param]="+id.toString()
      dataType : 'script'
      success: () ->
        $("#imgPreviewModal").modal('show')
        false

  $(".collection").on "click", "#follow-group", ->
    followee_id = $(this).attr("data-id")
    $(this).text("Unfollow")
    $(this).addClass("active")
    $(this).attr("id","unfollow-group")

    Rails.ajax
      type: "POST"
      url: "/follows"
      data: "follow[followee]="+followee_id.toString()
      dataType: 'json'
      success: () ->
        false

  $(".collection").on "click","#unfollow-group", ->
    followee_id = $(this).attr("data-id")
    $(this).text("Follow")
    $(this).removeClass("active")
    $(this).attr("id","follow-group")
    Rails.ajax
      type: "DELETE"
      url: "/follows/"+followee_id.toString()
      data: "follow[id]="+followee_id.toString()
      dataType: 'json'
      success: () ->
        false