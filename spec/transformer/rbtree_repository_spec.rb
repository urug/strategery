require File.dirname(__FILE__) + '/../spec_helper'

include SVM::Transformer
describe RBTreeRepository do
  
  it "should create a MultiRBTree instance" do
    RBTreeRepository.new.repository.should be_is_a(MultiRBTree)
  end
  
  it "should allow addition to the repository through []=" do
    @rbtree = RBTreeRepository.new
    @rbtree[1] = 0
    @rbtree.repository[1].should eql(0)
  end
  
  it "should allow multiple entries for a single key" do
    @rbtree = RBTreeRepository.new
    @rbtree[1] = 0
    @rbtree[1] = 1
    @rbtree.repository.values.should eql([0,1])
  end
  
  it "should pass unknown methods to the repository" do
    @rbtree = RBTreeRepository.new
    @rbtree[1] = 0
    @rbtree[1] = 1
    @rbtree.values.should eql([0,1])
    lambda{@rbtree.each {|k,v| k }}.should_not raise_error
  end
  
  it "should find the average of all values" do
    @rbtree = RBTreeRepository.new
    @rbtree[1] = 1
    @rbtree[1] = 2
    @rbtree[1] = 3
    @rbtree.mean.should eql(2.0)
  end
  
  it "should convert arrays to vectors" do
    @rbtree = RBTreeRepository.new
    @rbtree[1] = [1,2]
    @rbtree[1] = [2,4]
    @rbtree[1] = [3,6]
    @rbtree.mean.should eql([2.0, 4.0])
  end

  it "should scale the values" do
    @rbtree = RBTreeRepository.new
    @rbtree[1] = -100
    @rbtree[1] = -10
    @rbtree[1] = 0
    @rbtree[1] = 10
    @rbtree[1] = 100
    scaled_values = @rbtree.scale.values
    scaled_values.max.should be_close(1, 0.00000000001)
    scaled_values.min.should be_close(-1, 0.00000000001)
    (scaled_values.inject(0) {|sum, x| sum += x} / scaled_values.size.to_f).should be_close(0, 0.00000000001)
  end
  
  it "should allow the values to be scaled into a discrete set ({-1,0,1})" do
    @rbtree = RBTreeRepository.new(:discrete_set)
    @rbtree[1] = -100
    @rbtree[1] = -10
    @rbtree[1] = 0
    @rbtree[1] = 10
    @rbtree[1] = 100
    @rbtree.scale.values.should eql([-1, -1, 0, 1, 1])
  end
  
  it "should allow the values to be scaled into a logic function (0 -> 1, sigmoidal)" do
    @rbtree = RBTreeRepository.new(:sigmoid)
    @rbtree[1] = -100
    @rbtree[1] = -10
    @rbtree[1] = 0
    @rbtree[1] = 10
    @rbtree[1] = 100
    scaled_values = @rbtree.scale.values
    scaled_values.max.should be_close(1, 0.00000000001)
    scaled_values.min.should be_close(0, 0.00000000001)
    (scaled_values.inject(0) {|sum, x| sum += x} / scaled_values.size.to_f).should be_close(0.5, 0.00000000001)
  end
  
end

