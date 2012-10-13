require 'spec_helper'

def create_order_book name = 'Gott och blandat'
  admin = create_user 'admin@gottochblandat.fr', 'ttog'
  create_order_book_with_admin admin, name
end

def create_order_book_with_admin admin, name = 'Gott och blandat med admin'
  order_book = OrderBook.new :admin => admin, :name => name
  CouchPotato.database.save_document order_book
  order_book
end

def add user, order_book
  order_book.add_user user
  CouchPotato.database.save_document order_book
end

feature 'as a user I want to see a list of all order books I care about' do
  scenario 'list order books I administer' do
    user = create_and_sign_in_user
    order_book = create_order_book_with_admin user
    visit '/order_books'
    page.should have_content order_book.name
  end

  scenario 'list order books I use' do
    user            = create_and_sign_in_user
    order_book      = create_order_book 'Sega gubbar'
    concurrent_book = create_order_book 'Sega gummor'
    add user, order_book
    visit '/order_books'
    page.should     have_content      order_book.name
    page.should_not have_content concurrent_book.name
  end

  scenario 'navigate to order book page' do
    user            = create_and_sign_in_user
    order_book      = create_order_book 'Sega gubbar'
    add user, order_book
    visit '/order_books'
    click_on order_book.name
    page.current_url.should =~ Regexp.new( "order_books/#{order_book.id}" )
  end
end