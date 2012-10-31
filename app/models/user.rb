class User
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :email
  property :locale

  validates_with EmailUniquenessValidator

  def User::find_by_email email
    CouchPotato.database.first User.by_email( :key => email )
  end

  view :by_email, :key => :email
end