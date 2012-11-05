class Instrument
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :name
  property :description
  property :bids,   :type => [Order]
  property :offers, :type => [Order]

  validates :name, :presence => true

  def add_bid price, volume = 1
    new_order = Order.new :price => price.to_f, :volume => volume.to_f
    self.bids ||= []
    self.bids << new_order
  end

  def add_offer price, volume = 1
    new_order = Order.new :price => price.to_f, :volume => volume.to_f
    self.offers ||= []
    self.offers << new_order
  end
end