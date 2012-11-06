class Order
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :price, :type => Float
  property :volume, :type => Float

  Order::BID = 'bid'
  Order::OFFER = 'offer'
end
