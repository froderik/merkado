class Instrument
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :name
  property :description
  property :order_book_id, :type => String

  validates :name, :presence => true

  def add_bid user_id, price, volume = 1
    new_order = Bid.new(
      :price => price.to_f,
      :volume => volume.to_f,
      :user_id => user_id,
      :created_at => Time.zone.now,
      :instrument_id => id
    )
    new_order.save
    match_orders
  end

  def add_offer user_id, price, volume = 1
    new_order = Offer.new(
      :price => price.to_f,
      :volume => volume.to_f,
      :user_id => user_id,
      :created_at => Time.zone.now,
      :instrument_id => id
    )
    new_order.save
    match_orders
  end

  def bids
    Bid.find_by_instrument self
  end

  def offers
    Offer.find_by_instrument self
  end

  def match_orders
    _, _, trades, to_save, to_destroy = Instrument::match_orders(bids, offers)
    add_trades trades
    to_save.each { |order| order.save }
    to_destroy.each { |order| order.destroy }
  end

  def add_trades trades
    trades.each do |one_trade|
      one_trade.instrument_id = self.id
      one_trade.save
    end
  end

  def self.match_orders bids, offers, to_save = [], to_destroy = []
    first_bid = bids.first
    first_offer = offers.first
    if not (first_bid and first_offer)
      [bids, offers, [], to_save, to_destroy]
    elsif first_bid.price >= first_offer.price
      volume = [first_bid.volume, first_offer.volume].min
      price = (first_bid.price + first_offer.price) / 2

      trade_bid,   bids   = order_with_volume volume, bids, to_save, to_destroy
      trade_offer, offers = order_with_volume volume, offers, to_save, to_destroy

      trade = Trade.new :buyer => trade_bid.user_id, :seller => trade_offer.user_id, :volume => volume, :price => price, :created_at => Time.zone.now
      bids, offers, trades, to_save, to_destroy = match_orders bids, offers, to_save, to_destroy
      trades << trade
      [bids, offers, trades, to_save, to_destroy]
    else
      [bids, offers, [], to_save, to_destroy]
    end
  end

  def self.order_with_volume volume, orders, to_save, to_destroy
    if orders.first.volume == volume
      new_order = orders.shift
      to_destroy << new_order
      [new_order, orders]
    elsif orders.first.volume > volume
      orders.first.volume -= volume
      to_save << orders.first
      [orders.first, orders]
    end
  end

  def self.find_by_order_book_id order_book_id
    CouchPotato.database.view Instrument.by_order_book_id( :key => order_book_id )
  end

  view :by_order_book_id, :key => :order_book_id
end