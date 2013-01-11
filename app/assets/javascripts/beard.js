var beard = beard || {};

beard.songAutocomplete = function (textboxSelector, onCallback, onSelect) {
    var $textbox = $(textboxSelector);

    if ($textbox.length > 0) {
        $textbox.autocomplete({
            source: function (request, response) {
                $.get(
                    "/songs/autocomplete",
                    {
                        rows: 12,
                        term: request.term
                    },
                    function (data) {
                        if (onCallback)
                            onCallback(data, request, response)
                        else
                            response($.map(data, function (item) {
                                return {
                                    text: item.name,
                                    label: highlight(item.name, request.term),
                                    value: item.id
                                }
                            }))
                    })
            },
            select: function (event, ui) {
                if (onSelect)
                    return onSelect(event, ui, $textbox)
            }
        }).data( "autocomplete" )
            ._renderItem = function ( ul, item ) {
            return $( "<li>" )
                .data( "item.autocomplete", item )
                .append( $( "<a>" ).html(item.label) )
                .appendTo( ul )
        }
    }
    else
        console.log("Textbox for autocomplete not found.");
}

function highlight (s, t) {
    var matcher = new RegExp("("+$.ui.autocomplete.escapeRegex(t)+")", "ig" );
    return s.replace(matcher, "<strong>$1</strong>");
}