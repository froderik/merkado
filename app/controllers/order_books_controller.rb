class OrderBooksController < ApplicationController
  def index
    @order_books = CouchPotato.database.view OrderBook.by_name( :key => session[:user_id] )
  end
end