class TradesController < ApplicationController
  def index
    @instrument = Couch.find_by_id params[:instrument_id]

    @trades = Trade.find_by_instrument_id params[:instrument_id]
    involved_user_ids = @trades.map { |one_trade| [one_trade.buyer, one_trade.seller] } .flatten.uniq
    @users = Couch.find_mapped_by_id involved_user_ids
  end
end
