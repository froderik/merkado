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
end
