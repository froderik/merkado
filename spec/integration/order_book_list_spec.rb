require 'spec_helper'

def create_order_book options
  fail 'an order book needs an admin' unless options[:admin]
  order_book = OrderBook.new
  order_book.admin = options[:admin]
  order_book.name = options[:name]
  CouchPotato.database.save_document order_book
end

feature 'as a user I want to see a list of all order books I care about' do
  scenario 'list order books I administer' do
    user = create_and_sign_in_user
    create_order_book :admin => user, :name => 'Gott och blandat'
    visit '/order_books'
    page.should have_content 'Gott och blandat'
  end
end