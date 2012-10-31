require 'spec_helper'

class DummyDocument
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :value
end

describe Couch do
  before do
    @doc = DummyDocument.new
    @doc.value = 'a value'
    @doc.save
  end

  it 'should save and be found' do
    retrieved_document = Couch.find_by_id @doc.id
    retrieved_document.value.should == @doc.value
  end

  it 'should destroy' do
    @doc.destroy
    @doc.id.should be_nil
  end
end
