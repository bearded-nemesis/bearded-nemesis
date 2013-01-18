# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  onCallback = (data, request, response) ->
    response($.map(data, (item) ->
      # If song is already in list, return
      if $("input[name='songs[]'][value="+item.id+"]").length > 0
        return;

      return {
        label: highlight(item.name, request.term),
        value: item.id
      }
    ))

  onSelect = (event, ui, $textbox) ->
    $hidden = $("<input>").attr("type", "hidden").attr("name", "songs[]").val(ui.item.value)
    $("<li>").append(ui.item.label).append($hidden).prependTo($("#songs"))
    $textbox.val("")
    return false

  $playlistSongsAutocomplete = new Beard.Songs.Search("#add-song-text", onCallback, onSelect)

  $("#players").chosen()
)