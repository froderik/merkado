require 'spec_helper'

feature 'as an order book user I want to place bids and offers - ' do
  scenario 'place a bid' do
    user = create_and_sign_in_user
    order_book = create_order_book
    add user, order_book
    add create_instrument, order_book
  end
end
