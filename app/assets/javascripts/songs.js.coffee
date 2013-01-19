# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  $('.ownership').click((evt)->
    evt.preventDefault()
    link = $(this)
    url = link.data("url");
    does_own = link.hasClass "label-success"

    $.post url, {'does_own': !does_own}, (data)->
      link.toggleClass "label-success"
      link.text if does_own then "No" else "Yes"
  )
  
  $("#submit-filter").click((evt)->
    $aggregate = $("#filter input:checked")
    
    filter = ""
    filter += $(input).val() + "," for input in $aggregate           
    filter = filter.replace(/\ /g,"+")
    
    window.location = "/songs?filter=" + filter 
  )

  $("#filter .dropdown-menu").click((evt)->
    evt.stopPropagation()
  )

  ratingsPopup = new Beard.Widgets.Songs.RatingsWindow "#ratings-popup"
)