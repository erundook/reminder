# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  # setup pickers
  $('#time').timepicker
    showMeridian: false
    defaultTime: false
    disableFocus: true
  $('#date').datepicker
    weekStart: 1
    language: 'ru'
    autoclose: true
    format: 'dd.mm.yyyy'

  # show msg limit if phone entered
  if $('#phone').val().match(/^\d{10}$/)
    $.getJSON "/check_msg_limit?phone=#{$('#phone').val()}", (data) ->
      $('#count').html(data.count)
      $('.msg_counter').slideDown(300)
      if data.verified
        $('.captcha_row').slideUp(300) if $('.captcha_row').is(':visible')
      else
        $('.captcha_row').slideDown(300)
  $('#phone').keyup ->
    if $(this).val().match(/^\d{10}$/)
      $.getJSON "/check_msg_limit?phone=#{$(this).val()}", (data) ->
        if data.verified
          $('.captcha_row').slideUp(300) if $('.captcha_row').is(':visible')
        else
          $('.captcha_row').slideDown(300)
        $('#count').html(data.count)
        $('.msg_counter').slideDown(300)
    else
      $('.msg_counter').slideUp(300)

  # form responder
  $('.form-horizontal').bind 'ajax:success', (e, data) ->
    if data.status == 'ok'
      $('.alert').addClass('alert-success').removeClass('alert-error')
      $('.captcha_row').slideUp(300) if $('.captcha_row').is(':visible')
      $('#message').val('')
    else
      $('.alert').addClass('alert-error').removeClass('alert-success')
    $('.response .alert-content').html(data.message)
    $('.response').fadeIn(200).delay(1500).fadeOut(200)
    $('#count').html(data.paid_messages)
    $('#total_count').html(data.total_count)
