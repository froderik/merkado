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

  def price_decimals_count
    price.to_s =~ /.0$/ ? 0 : price.to_s.split('.')[1].size
  end

  def volume_decimals_count
    volume.to_s =~ /.0$/ ? 0 : volume.to_s.split('.')[1].size
  end

  def self.format number, decimals = 0
    sprintf "%.#{decimals}f", number
  end
end
