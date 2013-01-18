# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Beard.Songs.Search
  constructor: (textboxSelector, onCallback, onSelect) ->
    $textbox = $(textboxSelector)

    if $textbox.length <= 0
      console.log "Textbox with the selector ["+textboxSelector+"] not found."
      return

    $textbox.autocomplete(
      {source: this._source, select: this._select}
    ).data( "autocomplete" )
      ._renderItem = (ul, item) ->
        return $("<li>")
          .data("item.autocomplete", item)
          .append( $("<a>" ).html(item.label))
          .appendTo(ul)

  _source: (request, response) ->
    $.get("/songs/autocomplete", {rows:12, term:request.term}, (data) =>
      if this.onCallback
        this.onCallback(data, request, response)
      else
        response($.map(data, (item) =>
          return {
            text: item.name,
            label: this._highlight(item.name, request.term),
            value: item.id
          }
        ))
    )

  _select: (event, ui) ->
    if this.onSelect
      this.onSelect(event, ui, $textbox)

  _highlight: (s, t) ->
    matcher = new RegExp("("+$.ui.autocomplete.escapeRegex(t)+")", "ig" )
    return s.replace(matcher, "<strong>$1</strong>")

$(->    
  $(".add-ratings").click((evt)->
    evt.preventDefault()
    
    self = this
    
    url = $(this).attr("href")
    method = $(this).data("httpMethod")
    
    if (method == "PUT")
      $.get(url, (data)->
        rating.parse data
        showPopup(self, url, method)        
      )
    else
      rating.parse {}
      showPopup(self, url, method)
  )
  
  $(".star-rating a").click((evt)->
    evt.preventDefault()      

    $wrapper = $(this).closest("ul")
    $wrapper.find("a").removeClass("current-rating")
    $wrapper.siblings("#rating_" + $wrapper.data("hiddenField")).val($(this).text())


    # $wrapper = $(this).closest(".star-rating");
    
    $(this).addClass("current-rating")

    $('#ratings-popup form').submit()
  )
  
  $('#ratings-popup form').ajaxForm({
    success: (data, status, xhr, form) ->
      if(data.url != undefined)
        form.attr("action", data.url).attr("method", "PUT")
        $ratingsPopup.opener.attr("href", data.url).data("httpMethod", "PUT")
  })

  $('.ownership').click((evt)->
    evt.preventDefault()
    link = $(this)
    url = link.data("url");
    does_own = link.hasClass "label-success"

    $.post url, {'does_own': !does_own}, (data)->
      link.toggleClass "label-success"
      link.text if does_own then "No" else "Yes"
  )  
  
  $("#ratings-popup .close").click((evt)->
    $ratingsPopup.opener = null
    $ratingsPopup.removeClass("show")
  )
  
  $("#submit-filter").click((evt)->
    $aggregate = $("#filter input:checked")
    
    filter = ""
    filter += $(input).val() + "," for input in $aggregate           
    filter = filter.replace(/\ /g,"+")
    
    window.location = "/songs?filter=" + filter 
  )

  $("#filter .dropdown-menu").click((evt)->
    evt.stopPropagation()
  )

  $ratingsPopup = $("#ratings-popup")

  showPopup = (self, url, method) ->
    $ratingsPopup.find("form").attr("action", url).attr("method", method)
    pos = $(self).position()
    $ratingsPopup.opener = $(self)
    $ratingsPopup.css({
    top: (pos.top - 39) + "px",
    left: (pos.left - 360) + "px"
    }).addClass('show')

  ko.applyBindings(rating)
)

ko.bindingHandlers.checkStarRating = {
  update: (element, valueAccessor, allBindingsAccessor) ->
    value = valueAccessor()
    allBindings = allBindingsAccessor()         
    valueUnwrapped = ko.utils.unwrapObservable(value)         
    ratingIndex = allBindings.ratingIndex
    
    if (valueUnwrapped == ratingIndex)  
      $(element).addClass("current-rating")
    else
      $(element).removeClass("current-rating")    
}

rating = {
    guitar: ko.observable(),
    bass: ko.observable(),
    drums: ko.observable(),
    vocals: ko.observable(),
    keyboard: ko.observable(),
    pro_guitar: ko.observable(),
    pro_bass: ko.observable(),
    pro_drums: ko.observable(),
    pro_vocals: ko.observable(),
    pro_keyboard: ko.observable(),
    overall: ko.observable(),    
    parse: (data) ->
      this.guitar(data.guitar || 0)
      this.bass(data.bass || 0)
      this.drums(data.drums || 0)
      this.vocals(data.vocals || 0)
      this.keyboard(data.keyboard || 0)
      this.pro_guitar(data.pro_guitar || 0)
      this.pro_bass(data.pro_bass || 0)
      this.pro_drums(data.pro_drums || 0)
      this.pro_vocals(data.pro_vocals || 0)
      this.pro_keyboard(data.pro_keyboard || 0)
      this.overall(data.overall || 0)
}