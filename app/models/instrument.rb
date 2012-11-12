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
    self.bids << new_order
    self.bids.sort! { |one, other| other.price <=> one.price }
    self.is_dirty
  end

  def add_offer user_id, price, volume = 1
    new_order = Order.new :price => price.to_f, :volume => volume.to_f, :user_id => user_id, :created_at => Time.zone.now
    self.offers ||= []
    self.offers << new_order
    self.offers.sort! { |one, other| one.price <=> other.price }
    self.is_dirty
  end
end