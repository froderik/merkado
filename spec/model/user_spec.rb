require 'spec_helper'

describe User do
  subject { create_user 'f@f.se', 'yada' }

  it "should have unique emails" do
    similar = User.new
    similar.email = subject.email
    similar.should_not be_valid
  end

  it 'should have mandatory fields' do
    subject.should validate_presence_of_field :email
  end

end
