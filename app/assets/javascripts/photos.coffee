# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $(".photo-upload").click ->
    $("#new-photo").click()

  $("#photo-upload").validate
    rules:
      'photo[title]':
        required: true
        maxlength: 140
      'photo[desc]':
        required: false
        maxlength: 300
      'photo[private]':
        required: true
      'photo[img]':
        required:true

  $("#new-photo-submit").click (e) ->
    if $("#new-photo").val() == ""
      if $(this).attr("data-mode") == "new"
        alert("You haven't selected any photo yet")
        e.preventDefault()
    return

  $("#new-photo").change (e) ->
    input = e.target
    if input.files and input.files[0]
      file = input.files[0]
      reader = new FileReader()

      reader.readAsDataURL(file)
      reader.onload = (e) ->
        mimeType = reader.result.split(",")[0].split(":")[1].split(";")[0];
        if ["image/png","image/jpeg","image/jpg","image/gif"].includes(mimeType)
          $(".photo-upload").html("<img src=\""+reader.result+"\" class=\"photo-upload img-fit\">")
        else
          # $(this).trigger("reset")
          $(this).val('')
          alert "This file type is not supported"
    return
