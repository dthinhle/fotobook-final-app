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
      url: "/get_photos"
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
      url: "/get_photos"
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
      url: "/get_follows"
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
      url: "/get_follows"
      data: "data[param]="+id.toString()+"&data[mode]=followees"
      dataType: 'script'
      success: () ->
        false

  $("#editprofile").click ->
     window.location.href = "/edit_profile"

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

    unless !id or id.length == 0
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

    unless !id or id.length == 0
      Rails.ajax
        type: "POST"
        url: "/task"
        data: "request[task]=unlock&request[param]="+id.toString()
        dataType: 'json'
        success: () ->
          false

  $(".collection").on "click",".img-fit",->
    id = $(this).attr("data-id")
    unless !id or id.length == 0
      Rails.ajax
        type: "GET"
        url: "/photo_preview"
        data: "request[param]="+id.toString()
        dataType: 'script'
        success: () ->
          $("#imgPreviewModal").modal('show')
          false


  $(".collection").on "click",".img-above-2", ->
    id = $(this).attr("data-id")
    unless !id or id.length == 0
      Rails.ajax
        type: "GET"
        url: "/album_preview"
        data: "request[param]="+id.toString()
        dataType : 'script'
        success: () ->
          $("#imgPreviewModal").modal('show')
          false

  $(".collection").on "click", "#follow-group", ->
    followee_id = $(this).attr("data-id")
    followBtns = $("#follow-group\[data-id\=\'" + followee_id.toString() + "\'\]")
    followBtns.text("Unfollow")
    followBtns.addClass("active")
    followBtns.attr("id","unfollow-group")

    Rails.ajax
      type: "POST"
      url: "/follows"
      data: "follow[followee]="+followee_id.toString()
      success: () ->
        false

  $(".collection").on "click","#unfollow-group", ->
    followee_id = $(this).attr("data-id")
    unfollowBtns = $("#unfollow-group\[data-id\=\'" + followee_id.toString() + "\'\]")
    unfollowBtns.text("Follow")
    unfollowBtns.removeClass("active")
    unfollowBtns.attr("id","follow-group")
    Rails.ajax
      type: "DELETE"
      url: "/follows/"+followee_id.toString()
      success: () ->
        false

# Edit profile

  $("#btn-file").click ->
    $("#new-file").click()

  $("#user-profile-picture").validate
    rules:
      "user[avatar]":
        accept: "image/*"
        extension: "png|jpeg|jpg|gif"
        required: true

  $("#avatar-submit").click (e) ->
    if $("#new-file").val() == ""
      alert("You haven't selected any photo yet")
      e.preventDefault()

  $("#new-file").change (e) ->
    input = e.target
    if input.files and input.files[0]
      file = input.files[0]
      reader = new FileReader()

      reader.readAsDataURL(file)
      reader.onload = (e) ->
        mimeType = reader.result.split(",")[0].split(":")[1].split(";")[0];
        if ["image/png","image/jpeg","image/jpg","image/gif"].includes(mimeType)
          $(".editprofile-avatar").attr("src",reader.result)
        else
          $("#new-file").val('')
          alert "This file type is not supported"
    return



# jQuery validations

  jQuery.validator.addMethod "notEqual", ((value, element, param) ->
    console.log(value.toString() + $(param).val().toString())
    value != $(param).val()
  ), "Your new password can't be your old password"

  $("#user-info-form").validate
    rules:
      "user[first\_name]":
        required: true
        maxlength: 25
      "user[last\_name]":
        required: true
        maxlength: 25
      "user[email]":
        required: true
        email: true
        maxlength: 255

  $("#user-password-form").validate
    rules:
      "user[current\_password]":
        required: true
        minlength: 6
        maxlength: 64
      "user[password]":
        required: true
        minlength: 6
        maxlength: 64
        notEqual: "#user_current_password"
      "user[password\_confirmation]":
        required: true
        minlength: 6
        maxlength: 64
        equalTo: "#user_password"
    messages:
      "user[password\_confirmation]":
        equalTo: "Your password confirmation does not match."


  false