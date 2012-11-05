def create_order_book name = 'Gott och blandat'
  admin = create_user 'admin@gottochblandat.fr', 'ttog'
  create_order_book_with_admin admin, name
end

def create_order_book_with_admin admin, name = 'Gott och blandat med admin'
  order_book = OrderBook.new :admin => admin, :name => name
  order_book.save
  order_book
end

def add thing, order_book
  if thing.is_a? User
    order_book.add_user thing
  elsif thing.is_a? Instrument
    order_book.add_instrument thing
  else
    raise "Can't add things of the type #{thing.class}"
  end
  order_book.save
end

