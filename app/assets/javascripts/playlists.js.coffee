# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  onCallback = (data, request, response) ->
    response $.map data, (item) ->
      # If song is already in list, return
      return if $("input[name='songs[]'][value="+item.id+"]").length > 0

      return {
        label: search._highlight(item.name, request.term),
        id: item.id
      }

  onSelect = (event, ui, $textbox) ->
    $hidden = $("<input>").attr("type", "hidden").attr("name", "songs[]").val(ui.item.id)
    $("<li>").append(ui.item.label).append($hidden).prependTo($("#songs"))
    $textbox.val("")
    return false

  search = new Beard.Widgets.Songs.Search("#add-song-text", onCallback, onSelect)

  $("#players").chosen()
  $(".instrument-select").change((evt)->
    select = $(evt.target)
    url = select.data("url");
    player = select.data("player");
    instrument = select.val();

    $.ajax({
      url: url,
      type: "PUT",
      data: {'player': player, 'instrument': instrument},
      success: (data)->
        console.log "Instrument has been updated."
    })
  )
)