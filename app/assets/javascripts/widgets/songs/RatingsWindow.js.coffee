class Beard.Widgets.Songs.RatingsWindow
  constructor: (selector, triggers) ->
    @container$ = $(selector)
    @form$ = @container$.find "form"

    @container$.find(".close").click this._close
    @form$.ajaxForm success: this._onFormSubmitted
    $(".add-ratings").click this._onTriggerClicked
    $(".star-rating a").click this._onStarClicked

    @rating = new Beard.Models.Songs.Rating()
    ko.applyBindings @rating

  _doShow: (data) =>
    @rating.parse data
    @container$.addClass('show')

  _close: (evt) =>
    @container$.opener = null
    @container$.removeClass "show"

  _onFormSubmitted: (data) =>
    return unless data.url == undefined

    @form$.attr "action": data.url, "method": "PUT"
    @container$.opener.attr("href", data.url).data "httpMethod", "PUT"

  _onTriggerClicked: (evt) =>
    evt.preventDefault()

    target$ = $(evt.target)

    url = target$.attr "href"
    method = target$.data "httpMethod"

    @form$.attr "action": url, "method": method
    pos = target$.position()
    @container$.opener = target$
    @container$.css
      top: "#{pos.top - 39}px",
      left: "#{pos.left - 360}px"

    return this._doShow {} unless method == "PUT"
    $.get url, this._doShow

  _onStarClicked: (evt) =>
    evt.preventDefault()

    target$ = $(evt.target)

    wrapper$ = target$.closest "ul"
    wrapper$.find("a").removeClass "current-rating"
    wrapper$.siblings("#rating_" + wrapper$.data("hiddenField"))
      .val(target$.text()).change()
    target$.addClass "current-rating"

    @form$.submit()

  ko.bindingHandlers.checkStarRating = {
    update: (element, valueAccessor, allBindingsAccessor) ->
      value = valueAccessor()
      allBindings = allBindingsAccessor()
      valueUnwrapped = ko.utils.unwrapObservable(value)
      ratingIndex = allBindings.ratingIndex

      if valueUnwrapped == ratingIndex
        $(element).addClass "current-rating"
      else
        $(element).removeClass "current-rating"
  }
