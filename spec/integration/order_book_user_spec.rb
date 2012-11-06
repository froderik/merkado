require 'spec_helper'

feature 'as an order book user I want to place bids and offers - ' do
  scenario 'place a bid', :js => true do
    user = create_and_sign_in_user
    order_book = create_order_book
    add user, order_book
    instrument = create_instrument
    add instrument, order_book

    visit "/order_books/#{order_book.id}"

    within "##{instrument.id}" do
      click_on 'Bid'
    end
    fill_in 'price', :with => "125.43"
    fill_in 'volume', :with => "100"
    click_on 'Place'
    page.should have_content "125.43"
    page.should have_content "100"
  end
end
