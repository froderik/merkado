require 'spec_helper'

describe Trade do
  subject do
    trade = Trade.new :buyer => 'buyer', :seller => 'seller', :price => 100, :volume => 100, :instrument_id => 'nonsense'
    trade.save
    trade
  end

  it "must have a bid, an offer and timestamp" do
    subject.should validate_presence_of_field :buyer
    subject.should validate_presence_of_field :seller
    subject.should validate_presence_of_field :instrument_id
  end

  it "should be found by instrument" do
    Couch.find_by_id subject.id # waiting for mapping to occur....

    trades = Trade.find_by_instrument_id( 'nonsense' )
    trades.size.should == 1
    trades.first.id.should == subject.id
  end

  it "should be found by user" do
    Couch.find_by_id subject.id # waiting for mapping to occur....

    trades_bought = Trade.find_by_buyer_id 'nonsense', 'buyer'
    trades_bought.first.id.should == subject.id

    trades_sold = Trade.find_by_seller_id 'nonsense', 'seller'
    trades_sold.first.id.should == subject.id
  end
end
