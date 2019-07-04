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

  followee_id = window.location.pathname.match(/\d+$/)

  $(".button-container").on "click","#follow", ->

    $("#follow").text("Unfollow")
    $("#follow").attr("id","unfollow")
    Rails.ajax
      type: "POST"
      url: "/task"
      data: "request[task]=follow&request[param]="+followee_id[0]
      dataType: 'json'
      success: (data) ->
        console.log(data["follower"])

        Rails.ajax
          type: "POST"
          url: "/follows"
          data: "follow[follower]="+data["follower"]+"&follow[followee]="+data["followee"]
          dataType: 'json'
          success: () ->
            false

  $(".button-container").on "click","#unfollow", ->
    $("#unfollow").text("Follow")
    $("#unfollow").attr("id","follow")
    Rails.ajax
      type: "DELETE"
      url: "/follows/"+followee_id[0]
      data: "follow[id]="+followee_id[0]
      dataType: 'json'
      success: () ->
        false