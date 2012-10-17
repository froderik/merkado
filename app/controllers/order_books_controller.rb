class OrderBooksController < ApplicationController
  def index
    @admin_order_books = CouchPotato.database.view OrderBook.by_name( :key => session[:user_id] )
    @order_books = CouchPotato.database.view OrderBook.by_user( :key => session[:user_id] )
  end

  def show
    @order_book = CouchPotato.database.load params[:id]
    if session[:user_id] == @order_book.user_admin_id
      @new_instrument = Instrument.new
    end
  end

  def add_instrument
    @order_book = CouchPotato.database.load params[:id]
    instrument = Instrument.new params[:instrument]
    CouchPotato.database.save_document instrument
    instrument_list = @order_book.instrument_list || []
    new_instrument_list = Array.new instrument_list # have to create a new array to trigger save
    new_instrument_list << instrument
    @order_book.instrument_list = new_instrument_list
    CouchPotato.database.save_document @order_book
    render :partial => 'instrument_list', :locals => {:order_book => @order_book}, :content_type => 'text/plain'
  end
end
