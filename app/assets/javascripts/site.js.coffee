$(->
  $('.dropdown-toggle').dropdown()

  $('#song-search').submit((evt) ->
    evt.preventDefault()
    window.location = "/songs/search/" + $(this).find("input").val()
  )
)