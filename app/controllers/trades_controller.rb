class TradesController < ApplicationController
  def index
    @trades = Trade.find_by_instrument_id params[:instrument_id]
  end
end
