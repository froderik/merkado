class Offer < Order
  def self.find_by_instrument_id instrument_id
    super.find_by_instrument_id instrument_id
end
