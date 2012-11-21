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
    (by_buyer + by_seller).uniq!.sort { |one, other| other.timestamp <=> one.timestamp }
  end

  def self.trades_by_user_js kind
    """
    function(doc) {
      emit([doc['instrument_id'], doc['#{kind}']['user_id']], 1);
    }
    """
  end

  view :by_instrument_id, :key => :instrument_id
  view :by_buyer_id, :map => trades_by_user_js( 'bid' ), :type => :custom, :include_docs => true
  view :by_seller_id, :map => trades_by_user_js( 'offer' ), :type => :custom, :include_docs => true
end
