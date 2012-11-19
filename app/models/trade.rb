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

  def self.find_by_buyer_id buyer_id
    CouchPotato.database.view self.by_buyer_id( :key => buyer_id )
  end

  def self.find_by_seller_id seller_id
    CouchPotato.database.view self.by_seller_id( :key => seller_id )
  end

  def self.trades_by_user_js kind
    """
    function(doc) {
      emit(doc['#{kind}']['user_id'], 1);
    }
    """
  end

  view :by_instrument_id, :key => :instrument_id
  view :by_buyer_id, :map => trades_by_user_js( 'bid' ), :type => :custom, :include_docs => true
  view :by_seller_id, :map => trades_by_user_js( 'offer' ), :type => :custom, :include_docs => true
end
