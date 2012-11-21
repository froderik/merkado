class TradesController < ApplicationController
  def index
    @instrument = Couch.find_by_id params[:instrument_id]
    @order_book = Couch.find_by_id @instrument.order_book_id

    @is_admin = false

    if @order_book.admin? @user
      @trades = Trade.find_by_instrument_id params[:instrument_id]
      involved_user_ids = @trades.map { |one_trade| [one_trade.buyer, one_trade.seller] } .flatten.uniq
      @users = Couch.find_mapped_by_id involved_user_ids
      @is_admin = true
    else
      @trades = Trade.find_by_user_id params[:instrument_id], @user.id
    end
  end
end
