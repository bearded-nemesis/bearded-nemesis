class Beard.Widgets.DateTimePicker
  constructor: (dateChooser, timeChooser, hiddenValue) ->
    @dateChooser$ = $(dateChooser)
    @timeChooser$ = $(timeChooser)
    @hiddenValue$ = $(hiddenValue)

    @dateChooser$.datepicker().change this._updateEventDate
    @timeChooser$.timepickr resetOnBlur: false
    @timeChooser$.blur this._updateEventDate

  _updateEventDate: =>
    eDate = @dateChooser$.val()
    eTime = @timeChooser$.val()

    d = new Date eDate + " " + eTime
    @hiddenValue$.val d.format("isoDateTime")