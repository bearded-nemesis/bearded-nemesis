class Beard.Models.Songs.Rating
  constructor: ->
    @guitar = ko.observable()
    @bass = ko.observable()
    @drums = ko.observable()
    @vocals = ko.observable()
    @keyboard = ko.observable()
    @pro_guitar = ko.observable()
    @pro_bass = ko.observable()
    @pro_drums = ko.observable()
    @pro_vocals = ko.observable()
    @pro_keyboard = ko.observable()
    @overall = ko.observable()
    
  parse: (data) ->
    @guitar data.guitar || 0
    @bass data.bass || 0
    @drums data.drums || 0
    @vocals data.vocals || 0
    @keyboard data.keyboard || 0
    @pro_guitar data.pro_guitar || 0
    @pro_bass data.pro_bass || 0
    @pro_drums data.pro_drums || 0
    @pro_vocals data.pro_vocals || 0
    @pro_keyboard data.pro_keyboard || 0
    @overall data.overall || 0