def dummy_user_id; 'none'; end

def create_bid user_id = dummy_user_id, price = 100, volume = 1000
  Bid.new :volume => volume, :price => price, :user_id => user_id
end

def create_offer user_id = dummy_user_id, price = 100, volume = 1000
  Offer.new :volume => volume, :price => price, :user_id => user_id
end
