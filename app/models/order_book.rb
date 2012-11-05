class OrderBook
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :user_admin_id
  property :name
  property :user_ids, :type => [String]
  property :instrument_list, :type => [Instrument]

  def admin= admin_user
    self.user_admin_id = admin_user.id
  end

  def add_user user
    self.user_ids ? self.user_ids << user.id : self.user_ids = [user.id]
  end

  def add_instrument instrument
    self.instrument_list ||= []
    new_instrument_list = Array.new self.instrument_list # have to create a new array to trigger save
    new_instrument_list << instrument
    self.instrument_list = new_instrument_list
  end

  def self.order_books_by_userid_js
    """
    function(doc) {
      doc.user_ids.forEach(
        function(one_user_id){
          emit(one_user_id, doc);
        }
      );
    }
    """
  end

  def OrderBook::find_by_user_admin_id user_admin_id
    CouchPotato.database.view OrderBook.by_user_admin_id( :key => user_admin_id )
  end

  def OrderBook::find_by_user_id user_id
    CouchPotato.database.view OrderBook.by_user_id( :key => user_id )
  end

  view :by_user_admin_id, :key => :user_admin_id
  view :by_user_id, :key => :user_id, :map => order_books_by_userid_js, :type => :custom, :include_docs => true

end