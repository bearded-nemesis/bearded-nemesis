# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  onSelect = (event, ui, $textbox) ->
    $textbox.val(ui.item.text)
    false

  new Beard.Widgets.Songs.Search("#song-search .search-query", null, onSelect)
)