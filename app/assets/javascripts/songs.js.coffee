# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->    
  $('.add-ratings').click((evt)->
    evt.preventDefault()
    
    url = $(this).attr("href")
    method = $(this).data("http-method")      
    
    $modal = $("#ratings-modal") 
    $modal.find("form").attr("action", url).attr("method", method)
    
    if (method == "PUT")
      $.get(url, (data)->
        rating.parse(data)
                
        $modal.modal('show')        
      )
    else
      $modal.modal('show')            
  )
  
  $('#ratings-modal form').ajaxForm(-> 
    $("#ratings-modal").modal("hide")   
  )
  
  $('#save-ratings').click(->
    $('#ratings-modal form').submit()    
  )

  $('.ownership').click((evt)->
    evt.preventDefault()
    link = $(this)
    url = link.data("url");
    does_own = link.hasClass "label-success"

    $.post url, {'does_own': !does_own}, (data)->
      link.toggleClass "label-success"
      link.text if does_own then "No" else "Yes"
  )

  ko.applyBindings(rating) 
)

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