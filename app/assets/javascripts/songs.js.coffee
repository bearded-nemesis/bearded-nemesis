# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->    
  $(".add-ratings").click((evt)->
    evt.preventDefault()
    
    self = this
    
    url = $(this).attr("href")
    method = $(this).data("httpMethod")
    
    if (method == "PUT")
      $.get(url, (data)->
        rating.parse(data)
        showPopup(self, url, method)        
      )
    else
      rating.parse {}
      showPopup(self, url, method)
  )
  
  $(".star-rating a").click((evt)->
    evt.preventDefault()      
    
    $wrapper = $(this).closest(".star-rating");
    $wrapper.find("a").removeClass("current-rating")
    $wrapper.siblings("[type=hidden]").val($(this).text())
    
    $(this).addClass("current-rating")
    
    $('#ratings-popup form').submit()
  )
  
  $('#ratings-popup form').ajaxForm()

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
    $(this).closest("#ratings-popup").removeClass("show")
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

  ko.applyBindings(rating) 
)

showPopup = (self, url, method) ->
  $popup = $("#ratings-popup") 
  $popup.find("form").attr("action", url).attr("method", method)
  
  pos = $(self).position()

  $popup.css({
      top: (pos.top - 39) + "px",
      left: (pos.left - 254) + "px"
  }).addClass('show')

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
      this.guitar(data.guitar)
      this.bass(data.bass)
      this.drums(data.drums)
      this.vocals(data.vocals)
      this.keyboard(data.keyboard)
      this.pro_guitar(data.pro_guitar)
      this.pro_bass(data.pro_bass)
      this.pro_drums(data.pro_drums)
      this.pro_vocals(data.pro_vocals)
      this.pro_keyboard(data.pro_keyboard)
      this.overall(data.overall)
}