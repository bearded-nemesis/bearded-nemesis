# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  $("#add-song-text").autocomplete({
    source: (request, response) ->
      $.get(
        "/songs/autocomplete",
        {
          rows: 12,
          term: request.term
        },
        (data) ->
          response($.map(data, (item) ->
            return {
              label: highlight(item.name, request.term),
              value: item.id
            }
          ))
      )

    select: (event, ui) ->
      $("<li></li>").html(ui.item.label).prependTo($("#songs"))
      this.value = ""
      return false
  }).data( "autocomplete" )._renderItem = ( ul, item ) ->
    return $( "<li></li>" )
      .data( "item.autocomplete", item )
      .append( $( "<a></a>" ).html(item.label) )
      .appendTo( ul )
)

highlight = (s, t) ->
  matcher = new RegExp("("+$.ui.autocomplete.escapeRegex(t)+")", "ig" )
  return s.replace(matcher, "<strong>$1</strong>")