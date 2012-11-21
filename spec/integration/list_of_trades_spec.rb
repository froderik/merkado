require 'spec_helper'

feature 'as a user I want to see lists of trades' do
  scenario 'getting there' do
    user = create_and_sign_in_user
    order_book, instrument = create_order_book_with_one_instrument_traded_three_times user

    visit "/order_books/#{order_book.id}"

    click_on 'trades'

    page.current_url.should =~ /trades/

    all( '.trade' ).size.should == 3
    within '.trade' do
      page.should have_content user.email
    end
  end

  scenario 'user should not see other users trades' do
    user = create_and_sign_in_user
    admin = create_user
    order_book, instrument = create_order_book_with_one_instrument_traded_three_times admin

    visit "/trades?instrument_id=#{instrument.id}"
    all( '.trade' ).size.should == 0
  end

  scenario 'user should not see other own trades' do
    user = create_and_sign_in_user
    admin = create_user
    order_book, instrument = create_order_book_with_one_instrument_traded_three_times admin

    assert_trade_list_appearance instrument, user,  admin, 'bought', 1
    assert_trade_list_appearance instrument, admin, user,  'sold'  , 2
    assert_trade_list_appearance instrument, user,  user,  'both'  , 3
  end

  def assert_trade_list_appearance instrument, buyer, seller, expected_text, count
    instrument.add_bid buyer.id, 100, 100
    instrument.add_offer seller.id, 100, 100

    visit "/trades?instrument_id=#{instrument.id}"
    all( '.trade' ).size.should == count
    page.should have_content expected_text
  end
end
