class InstrumentsController < ApplicationController
  def place_order
    instrument = Couch.find_by_id params[:id]
    note = params[:note] if params[:note] and params[:note].size > 0
    if params[:type] == Order::BID
      instrument.add_bid @user.id, params[:price], params[:volume], note
    elsif params[:type] == Order::OFFER
      instrument.add_offer @user.id, params[:price], params[:volume], note
    end
    render :partial => 'order_books/instrument', :locals => {:instrument => instrument}, :content_type => 'text/plain'
  end

  def show
    instrument = Couch.find_by_id params[:id]
    render :partial => 'order_books/instrument', :locals => {:instrument => instrument}, :content_type => 'text/plain'
  end

  def destroy_order
    instrument = Couch.find_by_id params[:id]
    order = Couch.find_by_id params[:order_id]
    order.destroy
    render :partial => 'order_books/instrument', :locals => {:instrument => instrument}, :content_type => 'text/plain'
  end
end
