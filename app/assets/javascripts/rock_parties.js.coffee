# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

$ ->
  $("#attendees").chosen()
  new Beard.Widgets.DateTimePicker "#event-date", "#event-time", "#eventDate"

  $("#add-playlist").click =>
    $("#create-playlist-popup form").ajaxSubmit
      success: (data, status, xhr) =>
        $("<li><a href='" + xhr.getResponseHeader("location") + "'>" + data.name + "</a></li>").insertBefore("#addPlaylist")
        $("#create-playlist-popup").modal("hide")
