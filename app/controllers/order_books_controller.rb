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

  def instrument_list
    @order_book = Couch.find_by_id params[:id]
    render :partial => 'instrument_list', :locals => {:order_book => @order_book}
  end

  def add_instrument
    @order_book = Couch.find_by_id params[:id]
    instrument = Instrument.new params[:instrument]
    instrument.order_book_id = @order_book.id
    instrument.save
    render :partial => 'instrument_list', :locals => {:order_book => @order_book}, :content_type => 'text/plain'
  end

  def add_invite
    params[:email_list].split(",").each do | email |
      invite = Invite.new :email => email, :order_book_id => params[:order_book_id]
      invite.save
      InvitationMailer.invitation_email(invite).deliver
    end
    render :nothing => true
  end
end
