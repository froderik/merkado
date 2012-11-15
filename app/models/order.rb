class Order
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :price, :type => Float
  property :volume, :type => Float
  property :user_id

  Order::BID = 'bid'
  Order::OFFER = 'offer'

  def timestamp
    created_at
  end

  def formatted_price decimals = 0
    Order.format price, decimals
  end

  def formatted_volume decimals = 0
    Order.format volume, decimals
  end

  def self.format number, decimals = 0
    sprintf "%.#{decimals}f", number
  end
end
