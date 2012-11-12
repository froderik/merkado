class Order
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :price, :type => Float
  property :volume, :type => Float
  property :user_id

  Order::BID = 'bid'
  Order::OFFER = 'offer'
end
