require 'spec_helper'

describe Instrument do
  subject { create_instrument }

  it 'should have a name' do
    subject.should validate_presence_of_field :name
  end
end
