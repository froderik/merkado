class InstrumentsController < ApplicationController
  def place_order
    instrument = Couch.find_by_id params[:id]
    if params[:type] == Order::BID
      instrument.add_bid @user.id, params[:price], params[:volume]
    elsif params[:type] == Order::OFFER
      instrument.add_offer @user.id, params[:price], params[:volume]
    end
    instrument.save
    render :partial => 'order_books/instrument', :locals => {:instrument => instrument}, :content_type => 'text/plain'
  end

  def show
    instrument = Couch.find_by_id params[:id]
    render :partial => 'order_books/instrument', :locals => {:instrument => instrument}, :content_type => 'text/plain'
  end
end
