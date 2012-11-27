require 'spec_helper'

describe Invite do
  subject do
    invite = Invite.new :email => 'p@p.se', :order_book_id => 'nonsense'
    invite.save
    invite
  end

  it 'should have unique emails' do
    similar = Invite.new
    similar.email = subject.email
    similar.order_book_id = 'sense'
    similar.should_not be_valid
  end

  it 'should have mandatory fields' do
    subject.should validate_presence_of_field :email
    subject.should validate_presence_of_field :order_book_id
  end
end