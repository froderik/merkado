class Instrument
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :name
  property :description
  property :bids,   :type => [Order]
  property :offers, :type => [Order]

  validates :name, :presence => true

  def add_bid user_id, price, volume = 1
    new_order = Order.new :price => price.to_f, :volume => volume.to_f, :user_id => user_id, :created_at => Time.zone.now
    self.bids ||= []
    self.offers ||= []
    self.bids << new_order
    self.bids.sort! { |one, other| other.price <=> one.price }
    match_orders
    self.is_dirty
    save
  end

  def add_offer user_id, price, volume = 1
    new_order = Order.new :price => price.to_f, :volume => volume.to_f, :user_id => user_id, :created_at => Time.zone.now
    self.bids ||= []
    self.offers ||= []
    self.offers << new_order
    self.offers.sort! { |one, other| one.price <=> other.price }
    match_orders
    self.is_dirty
    save
  end

  def match_orders
    self.bids, self.offers, trades = Instrument::match_orders(bids, offers)
    add_trades trades
  end

  def add_trades trades
    trades.each do |one_trade|
      one_trade.instrument_id = self.id
      one_trade.save
    end
  end

  def self.match_orders bids, offers
    first_bid = bids.first
    first_offer = offers.first
    if not (first_bid and first_offer)
      [bids, offers, []]
    elsif first_bid.price >= first_offer.price
      volume = [first_bid.volume, first_offer.volume].min
      price = (first_bid.price + first_offer.price) / 2

      trade_bid,   bids   = order_with_volume volume, bids
      trade_offer, offers = order_with_volume volume, offers

      trade = Trade.new :bid => trade_bid, :offer => trade_offer, :volume => volume, :price => price, :created_at => Time.zone.now
      bids, offers, trades = match_orders bids, offers
      trades << trade
      [bids, offers, trades]
    else
      [bids, offers, []]
    end
  end

  def self.order_with_volume volume, orders
    if orders.first.volume == volume
      new_order = orders.shift
      [new_order, orders]
    elsif orders.first.volume > volume
      orders.first.volume -= volume
      [orders.first, orders]
    end
  end
end