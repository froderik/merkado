class Trade
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :bid,           :type => Order
  property :offer,         :type => Order
  property :price,         :type => Float
  property :volume,        :type => Float
  property :instrument_id, :type => String

  validates :bid,           :presence => true
  validates :offer,         :presence => true
  validates :price,         :presence => true
  validates :volume,        :presence => true
  validates :instrument_id, :presence => true

  def timestamp
    created_at
  end

  def seller
    offer.user_id
  end

  def buyer
    bid.user_id
  end

  def self.find_by_instrument_id instrument_id
    CouchPotato.database.view self.by_instrument_id( :key => instrument_id )
  end

  view :by_instrument_id, :key => :instrument_id
end
