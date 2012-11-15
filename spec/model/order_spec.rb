require 'spec_helper'

describe Order do
  subject { Order.new :volume => 1000, :price => 100 }

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
end
