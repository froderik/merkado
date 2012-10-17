class OrderBooksController < ApplicationController
  def index
    @admin_order_books = OrderBook.find_by_user_admin_id session[:user_id]
    @order_books       = OrderBook.find_by_user_id session[:user_id]
  end

  def show
    @order_book = Couch.find_by_id params[:id]
    if session[:user_id] == @order_book.user_admin_id
      @new_instrument = Instrument.new
    end
  end

  def add_instrument
    @order_book = Couch.find_by_id params[:id]
    instrument = Instrument.new params[:instrument]
    instrument.save
    instrument_list = @order_book.instrument_list || []
    new_instrument_list = Array.new instrument_list # have to create a new array to trigger save
    new_instrument_list << instrument
    @order_book.instrument_list = new_instrument_list
    @order_book.save
    render :partial => 'instrument_list', :locals => {:order_book => @order_book}, :content_type => 'text/plain'
  end
end
