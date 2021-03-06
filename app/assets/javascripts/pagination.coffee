$(document).on "turbolinks:load", ->

  $(window).on 'scroll', ->
    if $('#infinite-scrolling').size() > 0
      more_posts_url = $('.pagination .page-next').attr('href')
      mode = $('#infinite-scrolling').attr("data-mode")
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 400
        $('.pagination').html('<img src="https://i.imgur.com/uMQxKUN.gif" alt="Loading..." title="Loading..." />')
        path = /\w+/.exec(window.location.pathname)
        loadpath = if path == null then "discover" else path
        Rails.ajax
          type: "GET"
          url: "/load_#{loadpath}"
          data: "page=#{/\d+/.exec(more_posts_url)}&request[mode]=#{mode}"
      return
    return

  $(window).on 'scroll', ->
    if $('#infinite-scrolling-profile').size() > 0
      more_posts_url = $('.pagination .page-next').attr('href')
      mode = $('#infinite-scrolling-profile').attr("data-mode")
      user_id = $(".myprofile-avatar").attr("data-id")
      if $(".menu .text-primary").hasClass("btn-album") or $(".menu .text-primary").hasClass("btn-photo")
        url = "photos"
      else
        url = "follows"

      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 400
        $('.pagination').html('<img src="https://i.imgur.com/uMQxKUN.gif" alt="Loading..." title="Loading..." />')
        Rails.ajax
          type: "GET"
          url: "/load_#{url}"
          data: "page=#{(/page=\d+/.exec(more_posts_url)).toString().substr(5)}&data[param]=#{user_id}&data[mode]=#{mode}"
      return
    return