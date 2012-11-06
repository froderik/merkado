class InstrumentsController < ApplicationController
  def place_bid
    instrument = Couch.find_by_id params[:id]
    instrument.add_bid params[:price], params[:volume]
    instrument.save
    render :partial => 'order_books/instrument', :locals => {:instrument => instrument}, :content_type => 'text/plain'
  end
end
