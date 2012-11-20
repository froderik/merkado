class TradesController < ApplicationController
  def index
    @instrument = Couch.find_by_id params[:instrument_id]
    @trades = Trade.find_by_instrument_id params[:instrument_id]
  end
end
