require 'spec_helper'

describe Identity do
  subject { create_identity 'f@f.se', 'yada' }

  it 'should have unique emails' do
    similar = Identity.new
    similar.email = subject.email
    similar.password = "yay"
    similar.should_not be_valid
  end

  it 'should have mandatory fields' do
    subject.should validate_presence_of_field :email
    subject.should validate_presence_of_field :password_digest
  end
end
