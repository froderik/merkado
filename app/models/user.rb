class User
  include CouchPotato::Persistence

  property :email
  property :password

  view :by_email, :key => :email
end