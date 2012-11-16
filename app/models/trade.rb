class Trade
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :bid, :type => Order
  property :offer, :type => Order
  property :price, :type => Float
  property :volume, :type => Float

  def timestamp
    created_at
  end

  def seller
    offer.user_id
  end

  def buyer
    bid.user_id
  end
end
