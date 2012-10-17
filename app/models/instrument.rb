class Instrument
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :name
  property :description
end