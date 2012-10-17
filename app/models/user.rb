class User
  include CouchPotato::Persistence

  property :email
  property :locale

  view :by_email, :key => :email
end