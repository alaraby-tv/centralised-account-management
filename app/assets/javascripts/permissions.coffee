# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  jQuery ->
    permissions = $('.permission').html()
    $('.fields-for-permissions').hide()
    $('#access_request_access_account_id').change ->
      account = $('#access_request_access_account_id :selected').text()
      options = $(permissions).filter("optgroup[label='#{account}']").html()
      
      if options
        $('.fields-for-permissions').show()
        $('.permission').html(options)
      else
        $('.permission').empty()
        $('.fields-for-permissions').hide()

    $('.fields-for-permissions').on 'cocoon:after-insert', (e, insertedItem) ->
      account = $('#access_request_access_account_id :selected').text()
      options = $(permissions).filter("optgroup[label='#{account}']").html()
      insertedItem.find('.permission').html(options)

