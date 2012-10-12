class User
  include CouchPotato::Persistence

  property :email

  view :by_email, :key => :email
end