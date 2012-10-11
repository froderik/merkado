class OrderBook
  include CouchPotato::Persistence

  property :user_admin_id
  property :name

  def admin= admin_user
    self.user_admin_id = admin_user.id
  end

  view :by_name, :key => :user_admin_id
end