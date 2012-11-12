require 'spec_helper'

describe Instrument do
  let(:user){ create_user }
  subject { create_instrument }

  it 'should have a name' do
    subject.should validate_presence_of_field :name
  end

  it 'should add bids' do
    subject.add_bid user.id, 123.45, 1000
    subject.save
    subject.bids.size.should == 1
    subject.bids.first.price.should == 123.45
    subject.bids.first.volume.should == 1000
    subject.bids.first.user_id.should == user.id
  end

  it 'should add offers' do
    subject.add_offer user.id, 4711, 1.235
    subject.save
    subject.offers.size.should == 1
    subject.offers.first.price.should == 4711
    subject.offers.first.volume.should == 1.235
    subject.offers.first.user_id.should == user.id
  end

end
