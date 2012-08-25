# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('#time').timepicker
    showMeridian: false
    defaultTime: false
    disableFocus: true
  $('#date').datepicker
    weekStart: 1
    language: 'ru'
    autoclose: true
    format: 'dd.mm.yyyy'
  $('.form-horizontal').bind 'ajax:success', (e, data) ->
    if data.status == 'ok'
      $('.alert').addClass('alert-success').removeClass('.alert-error')
    else
      $('.alert').addClass('alert-error').removeClass('.alert-success')
    $('.response .alert-content').html(data.message)
    $('.response').fadeIn(200).delay(1500).fadeOut(200)
