require 'spec_helper'

describe Identity do
  subject { create_identity 'f@f.se', 'yada' }

  it "should have unique emails" do
    similar = Identity.new
    similar.email = subject.email
    similar.password = "yay"
    similar.should_not be_valid
  end
end
