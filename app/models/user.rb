class User
  include CouchPotato::Persistence
  include CouchHelpers

  property :email
  property :locale

  view :by_email, :key => :email
end