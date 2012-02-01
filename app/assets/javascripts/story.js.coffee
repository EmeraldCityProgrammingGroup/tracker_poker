# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class Story 
  constructor: ->
    progressDialogOpts = {
      title: "Voting Progress",
      model: true,
      autoOpen: false,
      height: 500,
      width: 500
    }
    $("#open_voting").dialog(progressDialogOpts)
    resultsDialogOpts = {
        title: "Voting Results",
        modal: true,
        autoOpen: false,
        height: 500,
        width: 500,
        open:  ->
          $("#vote_results").load("#{window.location}/votes")
        }
    $("#vote_results").dialog(resultsDialogOpts)
    $("#vote_progress").progressbar({value:0})
    
  updateProgress: ->
    $.ajax({
      url: "#{window.location}/status_voting",
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        $("#vote_progress").progressbar(data)
    })
$(document).ready ->
  story = new Story()
  window.updateProgress = story.updateProgress