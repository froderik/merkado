class Instrument
  include CouchPotato::Persistence
  include CouchHelpers

  property :name
  property :description
end