# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->  
  $('a.add-ratings').click(->
    if $(this).siblings('.rating-id').length > 0
      ratingId = $(this).siblings('.rating-id').val()
      
      url = "/songs/2/ratings/" + ratingId + "/edit.json"
      $.get(url, (data)->
        $('#ratings-modal').modal('show')
        console.log data
      )
    else
      alert "No go bro."
  )
)