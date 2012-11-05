
def create_instrument name = 'Svarta', description = 'Svarta som natten'
  instrument = Instrument.new
  instrument.name = name
  instrument.description = description
  instrument.save
  instrument
end
