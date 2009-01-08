require File.dirname(__FILE__) + '/../spec_helper'

include SVM::Transformer
describe CSV do
  before(:all) do
    @contents = [%w(this that), %w(this other)]
    FasterCSV.stub!(:open).and_return(@contents)
    @filename = 'test_filename'
  end
  
  it "should offer an instance, based on the filename" do
    instance = CSV.instance('some filename')
    instance2 = CSV.instance('some filename')
    instance3 = CSV.instance('other filename')

    instance.should be_is_a(CSV)
    instance.should eql(instance2)
    instance.should_not eql(instance3)
  end
  
  it "should store the contents of a file in an instance of the class" do
    obj = CSV.instance(@filename)
    CSV.contents(@filename).should eql(obj.contents)
  end
  
  it "load should work like contents" do
    obj = CSV.instance(@filename)
    CSV.contents(@filename).should eql(obj.contents)
  end
  
  it "should have an iterator over the contents" do
    contents = CSV.instance(@filename).contents
    contents.should_receive(:each)
    CSV.each_line(@filename) {|x| x}
  end
  
  it "should create a dictionary of unique values" do
    CSV.create_dictionary(@filename).should eql(%w(this that other))
  end
  
end

