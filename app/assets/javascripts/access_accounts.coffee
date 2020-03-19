# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  jQuery ->
    if $('#access_account_approvable').is(':checked')
      $('.approver').show()
    else
      $('.approver').hide()
    $('#access_account_approvable').click ->
      if $(this).is(':checked')
        $('.approver').show()
      else
        $('#access_account_approver_id').val(null)
        $('.approver').hide()