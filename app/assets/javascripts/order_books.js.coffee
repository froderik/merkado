# callback after adding an instrument
load_instrument_list = (xhr, data, status) ->
  $('.instrument_list').html(data)
  setup_order_placement()

load_instrument_list_and_hide_instrument_modal = (xhr, data, status) ->
  load_instrument_list(xhr, data, status)
  $('#add-instrument-modal').modal('hide')

add_instrument_list_callback = () ->
  $('.new_instrument').bind('ajax:success', load_instrument_list_and_hide_instrument_modal)

# callback after adding invitees
add_invite_callback = () ->
  $('#new_invites').bind('ajax:success', close_invite_modal)

close_invite_modal = () ->
  $('#add-invite-modal').modal('hide')


# setup place order scriptz
setup_order_placement = () ->
  place_order_enabler()
  place_order_callback()
  order_tooltips('.mine')
  order_popovers('.bid_note, .offer_note')
  $('.modal').bind('show', stop_loading )
  $('.modal').bind('hidden', setup_instrument_reloader )


# callback after placing an order
order_placed_succesfully = (xhr, data, status) ->
  instrument_id = $(this).attr('instrument_id')
  $('#' + instrument_id).html(data)
  $('#bid-' + instrument_id + '-modal').modal('hide')
  $('#offer-' + instrument_id + '-modal').modal('hide')

place_order_callback = () ->
  $('.place_order').bind('ajax:success', order_placed_succesfully)

# price and volume validator
validate_order = () ->
  order_form = $(this).closest('form')
  place_button = order_form.find('.place_order_button')
  price = order_form.find('.price_input').val()
  volume = order_form.find('.volume_input').val()
  if price and volume and price > 0 and volume > 0
    place_button.removeAttr('disabled')
  else
    place_button.attr('disabled', 'disabled')

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

# reload instruments regularly
setup_instrument_reloader = () ->
  intervalId = setInterval(load_instruments, 5000);
  $('.instrument_list').attr('interval-id', intervalId)

load_instruments = () ->
  orderbookid = $('.instrument_list').attr('id')
  $.get("/order_books/#{orderbookid}/instrument_list", (data) -> load_instrument_list('', data))

stop_loading = () ->
  interval_id = $('.instrument_list').attr('interval-id')
  clearInterval(interval_id)

# tooltips
order_tooltips = (selector) ->
  $(selector).tooltip('title': 'click to delete')

# popovers
order_popovers = (selector) ->
  $(selector).popover('title': 'Note')


# document.ready
$ ->
  add_instrument_list_callback()
  add_invite_callback()
  add_email_list_listener()
  setup_order_placement()
  setup_instrument_reloader()
  $('.destroy_link').bind('ajax:success', load_instruments)
