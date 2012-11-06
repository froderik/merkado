require 'spec_helper'

class DummyDocument
  include CouchPotato::Persistence
  include Couch::InstanceMethods

  property :value
end

describe Couch do
  before do
    @doc = DummyDocument.new :value => 'a value'
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

  it 'should find several by id' do
    other = DummyDocument.new :value => 'another value'
    other.save
    two = Couch.find_by_id [other.id, @doc.id]
    two.size.should == 2
  end
end
