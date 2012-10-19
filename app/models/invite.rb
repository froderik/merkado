class Invite
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :email
  property :consumed

  def User::find_by_email email
    CouchPotato.database.first User.by_email( :key => email )
  end

  view :by_email, :key => :email
end