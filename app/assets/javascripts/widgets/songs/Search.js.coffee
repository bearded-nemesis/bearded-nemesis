class Beard.Widgets.Songs.Search
  constructor: (textboxSelector, onCallback, onSelect) ->
    this.selection = onSelect
    this.callback = onCallback
    @textbox$ = $(textboxSelector)

    return unless @textbox$.length > 0

    @textbox$.autocomplete(
      {source: this._source, select: this._select, focus: this._focus}
    ).data( "autocomplete" )
      ._renderItem = (ul, item) ->
        $("<li>")
          .data("item.autocomplete", item)
          .append($("<a>").html(item.label))
          .appendTo(ul)

  _source: (request, response) =>
    $.get "/songs/autocomplete", {rows:12, term:request.term}, (data) =>
      if this.callback
        this.callback data, request, response
      else
        label = $.map data, (item) =>
          {
            text: item.name,
            label: this._highlight(item.name, request.term),
            value: item.id
          }

        response label

  _select: (event, ui) =>
    this.selection event, ui, @textbox$ if this.selection

  _focus: (event, ui) =>
    ui.item.value = ui.item.text

  _highlight: (s, t) ->
    matcher = new RegExp("("+$.ui.autocomplete.escapeRegex(t)+")", "ig" )
    s.replace(matcher, "<strong>$1</strong>")