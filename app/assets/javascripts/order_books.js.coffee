# callback after adding an instrument
load_instrument_list = (xhr, data, status) ->
  $('.instrument_list').html(data)
  $('#add-instrument-modal').modal('hide')

add_instrument_list_callback = () ->
  $('.new_instrument').bind('ajax:success', load_instrument_list)

# callback after adding invitees
add_invite_callback = () ->
  $('#new_invites').bind('ajax:success', close_invite_modal)

close_invite_modal = () ->
  $('#add-invite-modal').modal('hide')

# callback after placing an order
load_instrument = (xhr, data, status) ->
  instrument_id = $(this).attr('instrument_id')
  $('#' + instrument_id).html(data)
  $('#bid-' + instrument_id + '-modal').modal('hide')
  $('#offer-' + instrument_id + '-modal').modal('hide')

place_order_callback = () ->
  $('.place_order').bind('ajax:success', load_instrument)

# price and volume validator
validate_order = () ->
  order_form = $(this).closest('form')
  price = order_form.find('.price_input').val()
  volume = order_form.find('.volume_input').val()
  if price and volume and price > 0 and volume > 0
    $('#place_order_button').removeAttr('disabled')
  else
    $('#place_order_button').attr('disabled', 'disabled')

place_order_enabler = () ->
  $('.price_input').keyup(validate_order)
  $('.volume_input').keyup(validate_order)

# email validation
add_email_list_listener = () ->
  $('#email_list').keyup(validate_email_list)

validate_email_list = () ->
  email_list = $('#email_list').val()
  is_correct_format = email_list.split(',').every (x)-> x.length == 0 or /.+@.+\..+/.test(x.trim())
  if is_correct_format
    $('#send_invites_button').removeAttr('disabled')
  else
    $('#send_invites_button').attr('disabled', 'disabled')

# document.ready
$ ->
  add_instrument_list_callback()
  add_invite_callback()
  add_email_list_listener()
  place_order_callback()
  place_order_enabler()
