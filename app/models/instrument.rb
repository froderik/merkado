class Instrument
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :name
  property :description

  validates :name, :presence => true
end