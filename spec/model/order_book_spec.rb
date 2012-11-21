require 'spec_helper'

describe OrderBook do
  subject { create_order_book }
  let( :user ){ create_user }

  it 'should add users' do
    subject.add_user user
    subject.save

    users_order_books = OrderBook::find_by_user_id user.id
    user_ids = users_order_books.first.user_ids
    user_ids.size.should == 1
    user_ids.first.should == user.id
  end

  it 'should retrieve instruments' do
    instrument = create_instrument
    instrument.order_book_id = subject.id
    instrument.save
    subject.instrument_list.size.should == 1
    subject.instrument_list.first.name.should == default_instrument_name
  end

  it 'should have a name' do
    subject.should validate_presence_of_field :name
  end
end
