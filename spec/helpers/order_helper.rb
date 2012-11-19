def dummy_user_id; 'none'; end

def create_order
  Order.new :volume => 1000, :price => 100, :user_id => dummy_user_id
end
