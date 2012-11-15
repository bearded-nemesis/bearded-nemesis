# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->    
  $('a.add-ratings').click(->
    if $(this).siblings('.rating-id').length > 0
      songId = $(this).siblings('.song-id').val()
      ratingId = $(this).siblings('.rating-id').val()      
      
      url = "/songs/" + songId + "/ratings/" + ratingId + "/edit.json"
      $.get(url, (data)->
        rating.parse(data)
        
        $("#ratings-modal form").attr("action", "/songs/2/ratings/1.json").attr("method", "put");
        $('#ratings-modal').modal('show')        
      )
    else
      alert "No go bro."
  )
  
  $('#ratings-modal form').ajaxForm(-> 
    alert "Thank you for your comment!" 
  )
  
  $('#save-ratings').click(->
    $('#ratings-modal form').submit()    
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
      this.pro_guitar(data.guitar)
      this.pro_bass(data.bass)
      this.pro_drums(data.drums)
      this.pro_vocals(data.vocals)
      this.pro_keyboard(data.keyboard)
      this.overall(data.overall)
}