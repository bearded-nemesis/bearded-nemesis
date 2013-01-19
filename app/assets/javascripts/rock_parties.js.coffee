# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  $("#attendees").chosen()
  new Beard.Widgets.DateTimePicker "#event-date", "#event-time", "#eventDate"
  #$("#event-date").datepicker().change updateEventDate
  #$("#event-time").timepickr resetOnBlur: false
  #$("#event-time").blur updateEventDate
)

#updateEventDate = () ->
#  eDate = $("#event-date").val()
#  eTime = $("#event-time").val()
#
#  d = new Date eDate + " " + eTime
#  $("#eventDate").val d.format("isoDateTime")