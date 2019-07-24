# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $(".album-upload").click ->
    $("#new-album").click()

  $("#album-upload").validate
    rules:
      'album[title]':
        required: true
        maxlength: 140
      'album[desc]':
        required: false
        maxlength: 300
      'album[private]':
        required: true
      'album[img]':
        required:true

  $("#new-album-submit").click (e) ->
    if $("#new-album").val() == ""
      if $(this).attr("data-mode") == "new"
        alert("You haven't selected any photo yet")
        e.preventDefault()
    return

  $("#new-album").change (e) ->
    input = e.target
    if input.files and input.files[0]
      album = input.files

      reader = new FileReader()

      $(".album-fragment").remove()

      readFile = (index) ->
        if index >= album.length
          $("#progress-bar").css("width", "100%" )
          return
        else
          len = index / album.length *100
          $("#progress-bar").css("width", "#{len}%" )
          file = album[index];
          reader.onload = (e) ->
            mimeType = reader.result.split(",")[0].split(":")[1].split(";")[0];
            if ["image/png","image/jpeg","image/jpg","image/gif"].includes(mimeType)
              $(".album-container").append("<div class=\"album-fragment\"><img src=\"#{reader.result}\" class=\"album-fragment img-fit\"></div>")
            readFile(index+1)
          reader.readAsDataURL(file);

      readFile(0);
    return

  $(".btn-delete-photo").click ->
    photo_id = $(this).attr("data-id")
    Rails.ajax
      type: "DELETE"
      data: "album[task]=delete"
      url: "/photos/#{photo_id}"
      beforeSend: ->
        confirm('Are you sure you want to delete this photo?')
      success: ->
        $(".btn-delete-photo[data-id=#{photo_id}]").parent().remove()
        false