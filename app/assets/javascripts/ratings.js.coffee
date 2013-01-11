## Place all the behaviors and hooks related to the matching controller here.
## All this logic will automatically be available in application.js.
## You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(=>
  $(".star-rating a").click((evt)->
    evt.preventDefault()

    $wrapper = $(this).closest("ul")
    $wrapper.find("a").removeClass("current-rating")
    $wrapper.siblings("#rating_" + $wrapper.data("hiddenField")).val($(this).text())

    $(this).addClass("current-rating")
  ).each(()->
    $wrapper = $(this).closest("ul")
    currentValue = $wrapper.siblings("#rating_" + $wrapper.data("hiddenField")).val();

    if(currentValue == $(this).text())
      $(this).addClass("current-rating")
  )
)
