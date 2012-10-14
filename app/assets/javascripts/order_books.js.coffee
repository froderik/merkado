load_assets_list = (xhr, data, status) ->
  $('.asset_list').html(data)
  $('#add-asset-modal').modal('hide')

add_asset_callback = () ->
  $('.new_asset_info').bind('ajax:success', load_assets_list)

$ ->
  add_asset_callback()
