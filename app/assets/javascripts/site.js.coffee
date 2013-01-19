$(->
  $('.dropdown-toggle').dropdown()

  $('#song-search').submit (evt) ->
    evt.preventDefault()
    window.location = "/songs/search/" + $(evt.target).find("input").val()
)