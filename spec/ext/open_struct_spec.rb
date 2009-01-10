require File.dirname(__FILE__) + '/../spec_helper'

describe OpenStruct do
  it "should merge with hashes" do
    o = OpenStruct.new(:this => :that)
    o.merge(:one => :more)
    o.this.should eql(:that)
    o.one.should eql(:more)
  end
  
  it "should merge with open structs" do
    o1 = OpenStruct.new(:this => :that)
    o2 = OpenStruct.new(:one => :more)
    lambda{o1.merge(o2)}.should_not raise_error
    o1.this.should eql(:that)
    o1.one.should eql(:more)
  end
  
  it "should not merge with other types" do
    o = OpenStruct.new(:this => :that)
    lambda{o.merge(1)}.should raise_error
    lambda{o.merge('str')}.should raise_error
    lambda{o.merge([])}.should raise_error
  end
  
  it "should expose table" do
    h = {:this => :that}
    o = OpenStruct.new(h)
    # I don't know why I can't compare an identical hash, so I'm working
    # around that. 
    o.table.should be_is_a(Hash)
    o.table.keys.should eql(h.keys)
    o.table.values.should eql(h.values)
  end
end