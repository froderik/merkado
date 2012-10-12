class OrderBooksController < ApplicationController
  def index
    @admin_order_books = CouchPotato.database.view OrderBook.by_name( :key => session[:user_id] )
    @order_books = CouchPotato.database.view OrderBook.by_user( :key => session[:user_id] )
  end
end
