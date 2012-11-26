class Trade
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :buyer
  property :seller
  property :price,         :type => BigDecimal
  property :volume,        :type => BigDecimal
  property :instrument_id

  validates :buyer,           :presence => true
  validates :seller,         :presence => true
  validates :price,         :presence => true
  validates :volume,        :presence => true
  validates :instrument_id, :presence => true

  def timestamp
    created_at
  end

  def buyer? user
    buyer == user.id
  end

  def seller? user
    seller == user.id
  end

  def buyer_and_seller? user
    buyer?( user ) and seller?( user )
  end

  def self.find_by_instrument_id instrument_id
    CouchPotato.database.view self.by_instrument_id( :key => instrument_id )
  end

  def self.find_by_buyer_id instrument_id, buyer_id
    CouchPotato.database.view self.by_buyer_id( :key => [instrument_id, buyer_id] )
  end

  def self.find_by_seller_id instrument_id, seller_id
    CouchPotato.database.view self.by_seller_id( :key => [instrument_id, seller_id] )
  end

  def self.find_by_user_id instrument_id, user_id
    by_buyer = find_by_buyer_id instrument_id, user_id
    by_seller = find_by_seller_id instrument_id, user_id
    (by_buyer + by_seller).uniq.sort { |one, other| other.timestamp <=> one.timestamp }
  end

  view :by_instrument_id, :key => :instrument_id
  view :by_buyer_id, :key => [:instrument_id, :buyer]
  view :by_seller_id, :key => [:instrument_id, :seller]
end
