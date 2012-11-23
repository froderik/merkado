class Bid < Order
  def self.find_by_instrument_id instrument_id
    descending = true
    super.find_by_instrument_id instrument_id, descending
  end
end
