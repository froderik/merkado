class OrderBook
  include CouchPotato::Persistence

  property :user_admin_id
  property :name
  property :user_ids, :type => [String]

  def admin= admin_user
    self.user_admin_id = admin_user.id
  end

  def add_user user
    self.user_ids ? self.user_ids << user.id : self.user_ids = [user.id]
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

  view :by_name, :key => :user_admin_id
  view :by_user, :key => :user_id, :map => order_books_by_userid_js, :type => :custom, :include_docs => true

end