require 'spec_helper'

describe Instrument do
  let(:user){ create_user }
  subject { create_instrument }

  it 'should have a name' do
    subject.should validate_presence_of_field :name
  end

  it 'should add bids' do
    subject.add_bid user.id, 123.45, 1000
    subject.bids.size.should == 1
    subject.bids.first.price.should == 123.45
    subject.bids.first.volume.should == 1000
    subject.bids.first.user_id.should == user.id
    subject.bids.first.timestamp.should_not be_nil
  end

  it 'should add offers' do
    subject.add_offer user.id, 4711, 1.235
    subject.offers.size.should == 1
    subject.offers.first.price.should == 4711
    subject.offers.first.volume.should == 1.235
    subject.offers.first.user_id.should == user.id
    subject.offers.first.timestamp.should_not be_nil
  end

  it 'should match orders with same volume' do
    bids =   orders [100, 10], [90, 10]
    offers = orders [100, 10], [110, 10]

    new_bids, new_offers, trades = Instrument.match_orders bids, offers

    trades.size.should         == 1
    trades.first.price.should  == 100
    trades.first.volume.should == 10
    trades.first.seller.should == offers.first.user_id
    trades.first.buyer.should  == bids.first.user_id

    new_bids.size.should == 1
    new_bids.first.price.should == 90

    new_offers.size.should == 1
    new_offers.first.price.should == 110
  end

  it 'should match orders deeply' do
    bids =   orders [110, 10], [100, 10], [90, 10]
    offers = orders [100, 10], [100, 10], [110, 10]

    new_bids, new_offers, trades = Instrument.match_orders bids, offers

    new_bids.size.should == 1
    new_offers.size.should == 1
    trades.size.should == 2
  end

  it 'should match part of volumes' do
    bids =   orders [100, 20], [90, 10]
    offers = orders [100, 5], [110, 10]

    new_bids, new_offers, trades = Instrument.match_orders bids, offers

    new_bids.size.should == 2
    new_bids.first.volume.should == 15
    new_bids.first.price.should == 100

    new_offers.size.should == 1
    new_offers.first.price.should == 110

    trades.size.should == 1
    trades.first.volume.should == 5
    trades.first.price.should == 100
  end

  def orders *price_volume_tuples
    user_id = rand( 100000000000 ).to_s

    price_volume_tuples.map do |one_tuple|
      Order.new :price => one_tuple[0], :volume => one_tuple[1], :user_id => user_id
    end
  end
end
