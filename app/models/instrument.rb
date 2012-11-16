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
    trades.each {|one_trade| one_trade.save }
  end

  def self.match_orders bids, offers
    if bids.empty? or offers.empty?
      [bids, offers, []]
    elsif bids.first.price >= offers.first.price
      volume = bids.first.volume
      price = bids.first.price
      trade = Trade.new :bid => bids.shift, :offer => offers.shift, :volume => volume, :price => price
      bids, offers, trades = match_orders bids, offers
      trades << trade
      [bids, offers, trades]
    else
      [bids, offers, []]
    end
  end
end