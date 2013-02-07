# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

$ ->
  $("#submit-filter").click (evt)->
    $aggregate = $("#filter input:checked")
    
    filter = ""
    filter += $(input).val() + "," for input in $aggregate           
    filter = filter.replace(/\ /g,"+")
    
    window.location = "/songs?filter=" + filter

  $("#filter .dropdown-menu").click (evt)->
    evt.stopPropagation()

  $('.ownership').ajaxToggle()
  ratingsPopup = new Beard.Widgets.Songs.RatingsWindow "#ratings-popup"

  tableActions = new Beard.Widgets.Songs.TableActions "#songs", "#actions"
