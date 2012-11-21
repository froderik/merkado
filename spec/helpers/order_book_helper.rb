def create_order_book name = 'Gott och blandat'
  admin = create_user 'admin@gottochblandat.fr', 'ttog'
  create_order_book_with_admin admin, name
end

def create_order_book_with_admin admin, name = 'Gott och blandat med admin'
  order_book = OrderBook.new :admin => admin, :name => name
  order_book.save
  order_book
end

def create_order_book_with_one_instrument_traded_three_times admin
  order_book = create_order_book_with_admin admin
  instrument = create_instrument 'Godis'
  add instrument, order_book
  instrument.add_bid admin.id, 100, 100
  instrument.add_offer admin.id, 100, 100
  instrument.add_bid admin.id, 110, 100
  instrument.add_offer admin.id, 110, 100
  instrument.add_bid admin.id, 120, 100
  instrument.add_offer admin.id, 120, 100
  [order_book, instrument]
end

def add thing, order_book
  if thing.is_a? User
    order_book.add_user thing
    order_book.save
  elsif thing.is_a? Instrument
    thing.order_book_id = order_book.id
    thing.save
  else
    raise "Can't add things of the type #{thing.class}"
  end
end

