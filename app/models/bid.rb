class Bid < Order
  def self.find_by_instrument instrument
    find_by_instrument_id instrument.id
  end

  def self.find_by_instrument_id instrument_id
    orders = CouchPotato.database.view Bid.by_instrument_id( :key => instrument_id )
    orders.sort { |one, other| other.price <=> one.price } || []
  end

  view :by_instrument_id, :key => :instrument_id
end
