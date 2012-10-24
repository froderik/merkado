load_instrument_list = (xhr, data, status) ->
  $('.instrument_list').html(data)
  $('#add-instrument-modal').modal('hide')

add_instrument_callback = () ->
  $('.new_instrument').bind('ajax:success', load_instrument_list)

add_invite_callback = () ->
  $('#new_invites').bind('ajax:success', close_invite_modal)

close_invite_modal = () ->
  $('#add-invite-modal').modal('hide') 

$ ->
  add_instrument_callback()
  add_invite_callback()

#jquery document ready

# syntax coloring

#