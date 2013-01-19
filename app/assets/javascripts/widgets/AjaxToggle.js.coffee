# A class-based template for jQuery plugins in Coffeescript
#
#     $('.target').myPlugin({ paramA: 'not-foo' });
#     $('.target').myPlugin('myMethod', 'Hello, world');
#
# Check out Alan Hogan's original jQuery plugin template:
# https://github.com/alanhogan/Coffeescript-jQuery-Plugin-Template
#

# Reference jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend
# Change pluginName to your plugin's name.
  ajaxToggle: (options) ->
    # Default settings
    settings =
      option1: true
      option2: false
      debug: false

    # Merge default settings with options.
    settings = $.extend settings, options

    # Simple logger.
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


    # _Insert magic here._
    #return @each ()->
    #  log "Preparing magic show."
    #  # You can use your settings in here now.
    #  log "Option 1 value: #{settings.option1}"




#class Beard.Widgets.AjaxToggle
#  constructor: ->
#
#    $('.ownership').click((evt)->
#      evt.preventDefault()
#      link = $(this)
#      url = link.data("url");
#      does_own = link.hasClass "label-success"
#
#      $.post url, {'does_own': !does_own}, (data)->
#        link.toggleClass "label-success"
#        link.text if does_own then "No" else "Yes"
#    )