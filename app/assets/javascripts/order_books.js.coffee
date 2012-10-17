load_instrument_list = (xhr, data, status) ->
  $('.instrument_list').html(data)
  $('#add-instrument-modal').modal('hide')

add_instrument_callback = () ->
  $('.new_instrument').bind('ajax:success', load_instrument_list)

$ ->
  add_instrument_callback()
