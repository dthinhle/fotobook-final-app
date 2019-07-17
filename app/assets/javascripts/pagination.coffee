$(document).on "turbolinks:load", ->

  $(window).on 'scroll', ->
    if $('#infinite-scrolling').size() > 0
      more_posts_url = $('.pagination .page-next').attr('href')
      mode = $('#infinite-scrolling').attr("data-mode")
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 400
        $('.pagination').html('<img src="https://i.imgur.com/uMQxKUN.gif" alt="Loading..." title="Loading..." />')
        Rails.ajax
          type: "GET"
          url: "/load"+/\w+/.exec(window.location.pathname)
          data: "page="+/\d+/.exec(more_posts_url)+"&request[mode]="+mode
          success: () ->
            false
      return
    return