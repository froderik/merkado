load_instrument_list = (xhr, data, status) ->
  $('.instrument_list').html(data)
  $('#add-instrument-modal').modal('hide')

add_instrument_callback = () ->
  $('.new_instrument').bind('ajax:success', load_instrument_list)

add_invite_callback = () ->
  $('#new_invites').bind('ajax:success', close_invite_modal)

close_invite_modal = () ->
  $('#add-invite-modal').modal('hide') 

email_list_listener = () ->
  $('#email_list').keyup(validate_email_list)

validate_email_list = () ->
  email_list = $('#email_list').val()
  is_correct_format = email_list.split(',').every (x)-> x.length == 0 or /.+@.+\..+/.test(x.trim())
  if is_correct_format 
    $('#send_invites_button').removeAttr('disabled')
  else
    $('#send_invites_button').attr('disabled', 'disabled')

$ ->
  add_instrument_callback()
  add_invite_callback()
  email_list_listener()

#jquery document ready

# syntax coloring

#