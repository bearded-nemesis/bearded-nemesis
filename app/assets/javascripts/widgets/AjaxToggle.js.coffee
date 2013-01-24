$ = jQuery

$.fn.extend
  ajaxToggle: (options) ->
    settings =
      option1: true
      option2: false
      debug: false

    settings = $.extend settings, options

    log = (msg) ->
      console?.log msg if settings.debug

    this.click (evt) ->
      evt.preventDefault()
      link = $(evt.target)
      url = link.data("url");
      does_own = link.hasClass "label-success"

      $.post url, {'does_own': !does_own}, (data)->
        link.toggleClass "label-success"
        link.text if does_own then "No" else "Yes"
