require 'spec_helper'

describe Order do
  subject { create_bid }

  it 'should format volume' do
    subject.formatted_volume.should == '1000'
  end

  it 'should format price' do
    subject.formatted_price.should == '100'
  end

  it 'should count decimals' do
    subject.volume_decimals_count.should == 0
    subject.price_decimals_count.should == 0
    nother = Order.new :volume => 12.345, :price => 14.1
    nother.volume_decimals_count.should == 3
    nother.price_decimals_count.should == 1
  end

  it 'should format numbers' do
    assert_formatted_number 100, nil, '100'
    assert_formatted_number 100, 0, '100'
    assert_formatted_number 100, 1, '100.0'
    assert_formatted_number 100, 2, '100.00'
    assert_formatted_number 0.345, 4, '0.3450'
    assert_formatted_number 1345.79, 4, '1345.7900'
  end

  def assert_formatted_number number, decimals, expected
    Order.format( number, decimals ).should == expected
  end

  it 'has mandatory fields' do
    subject.should validate_presence_of_field :price
    subject.should validate_presence_of_field :volume
    subject.should validate_presence_of_field :user_id
    subject.should validate_presence_of_field :instrument_id
  end

  it 'should find orders by instrument' do
    subject.instrument_id = 'myid'
    subject.save

    another = create_bid 'nonsense', 99, 900
    another.instrument_id = 'myid'
    another.save

    athird = create_bid 'nonsense', 101, 900
    athird.instrument_id = 'myid'
    athird.save

    orders = Bid.find_by_instrument_id 'myid'
    orders.size.should == 3
    orders[0].price.should == 101
    orders[2].price.should == 99
  end


end
