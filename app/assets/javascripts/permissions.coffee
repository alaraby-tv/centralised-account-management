# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  jQuery ->
    $('.fields-for-permissions').hide()
    $('#access_request_access_account_id').change ->
      $('.fields-for-permissions').hide()
      account = $('#access_request_access_account_id :selected').text().toLowerCase()
      $(".#{account}").show()
      
      
        

