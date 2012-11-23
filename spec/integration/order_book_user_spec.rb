require 'spec_helper'

feature 'as an order book user I want to place bids and offers - ' do
  background do
    @user = create_and_sign_in_user
    @order_book = create_order_book
    add @user, @order_book
    @instrument = create_instrument
    add @instrument, @order_book
  end

  scenario 'place a bid', :js => true do
    visit "/order_books/#{@order_book.id}"

    within "##{@instrument.id}" do
      click_on 'Bid'
    end
    fill_in 'price', :with => "125.43"
    fill_in 'volume', :with => "100"
    click_on 'Place'
    page.find( '.bid_price', :text => "125.43" ).should_not be_nil
    page.find( '.bid_volume', :text => "100" ).should_not be_nil
  end

  scenario 'place an offer', :js => true do
    visit "/order_books/#{@order_book.id}"

    within "##{@instrument.id}" do
      click_on 'Offer'
    end
    fill_in 'price', :with => "225.43"
    fill_in 'volume', :with => "300"
    click_on 'Place'
    page.find( '.offer_price', :text => "225.43" ).should_not be_nil
    page.find( '.offer_volume', :text => "300" ).should_not be_nil
  end

  scenario 'remove a placed order' do
    @instrument.add_bid @user.id, 98, 100
    @instrument.add_bid @user.id, 97, 100
    @instrument.add_bid 'ya', 96, 100

    visit "/order_books/#{@order_book.id}"

    click_on '98'

    page.should have_content '97'
    page.should_not have_content '98'

    bids = Bid.find_by_instrument @instrument
    bids.size.should == 2

    find('.number', :text => '96').click
    page.should have_content '96'
  end
end
