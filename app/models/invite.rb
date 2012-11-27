class Invite
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :email
  property :consumed, :type => :boolean, :default => false
  property :order_book_id

  validates :email, :presence => true
  validates :order_book_id, :presence => true
  validates_with EmailUniquenessValidator

  def Invite::find_by_email email
    CouchPotato.database.first Invite.by_email( :key => email )
  end

  view :by_email, :key => :email
end