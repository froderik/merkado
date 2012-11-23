def dummy_user_id; 'none'; end

def create_order user_id = dummy_user_id, price = 100, volume = 1000
  Order.new :volume => volume, :price => price, :user_id => user_id
end
