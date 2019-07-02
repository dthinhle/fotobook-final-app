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

  $(".img-photo").click ->
    preview = $(this).attr('src')
    if $(".photoPreview").hasClass('d-none')
      $(".photoPreview").removeClass('d-none')
    $(".albumPreview").addClass('d-none')

    $(".img-preview-body>img").attr('src', preview)
    text = $(this).parents(".img-section").next()
    title = text.find(".title").text().trim()
    author = text.find(".text-primary").text().trim()
    desc = text.find(".text-secondary").text().trim()
    $("#imgPreview").text(title)
    $("#imgPreviewModal").find('.text-primary').text(author)
    $("#imgPreviewModal").find('.text-secondary').text(desc)
    $("#imgPreviewModal").modal('show')


  $(".img-above-2").click ->
    preview = $(this).attr('src')
    if $(".albumPreview").hasClass('d-none')
      $(".albumPreview").removeClass('d-none')
    $(".photoPreview").addClass('d-none')

    $(".img-preview-body>img").attr('src', preview)
    text = $(this).parents(".img-section").next()
    title = text.find(".title").text().trim()
    author = text.find(".text-primary").text().trim()
    desc = text.find(".text-secondary").text().trim()
    $("#imgPreview").text(title)
    $("#imgPreviewModal").find('.text-primary').text(author)
    $("#imgPreviewModal").find('.text-secondary').text(desc)
    $("#imgPreviewModal").modal('show')