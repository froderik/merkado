require 'spec_helper'

feature 'as an order book admin I want to perform administrative tasks - ' do
  scenario 'add instrument', :js => true do
    user = create_and_sign_in_user
    order_book = create_order_book_with_admin user, 'Gott och blandat'

    visit "/order_books/#{order_book.id}"
    click_on 'Add instrument'
    fill_in 'instrument_name',        :with => 'Gula'
    fill_in 'instrument_description', :with => 'A boring description about this asset'
    click_on 'Save'

    page.should have_content 'Gula'
  end
end