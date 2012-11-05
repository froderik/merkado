def default_instrument_name; 'Svarta'; end

def create_instrument name = default_instrument_name, description = 'Svarta som natten'
  instrument = Instrument.new
  instrument.name = name
  instrument.description = description
  instrument.save
  instrument
end
