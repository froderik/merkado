def create_order_book name = 'Gott och blandat'
  admin = create_user 'admin@gottochblandat.fr', 'ttog'
  create_order_book_with_admin admin, name
end

def create_order_book_with_admin admin, name = 'Gott och blandat med admin'
  order_book = OrderBook.new :admin => admin, :name => name
  CouchPotato.database.save_document order_book
  order_book
end

def add user, order_book
  order_book.add_user user
  CouchPotato.database.save_document order_book
end

