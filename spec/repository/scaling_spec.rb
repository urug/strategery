require File.dirname(__FILE__) + '/../spec_helper'

include SVM

describe "Scaling Array" do
  
  # To keep the workspace clean, I'll subclass Array
  class ScalingArray < Array
    include Scaling
  end
  
  before(:each) do
    @sa = ScalingArray.new
  end
  it "should have a scaling_method of :default_set" do
    @sa.scaling_method.should eql(:default_set)
  end
  
  it "should accept other scaling methods, if they are valid methods" do
    @sa.scaling_method = :sigmoid
    @sa.scaling_method.should eql(:sigmoid)
    @sa.scaling_method = :discrete_set
    @sa.scaling_method.should eql(:discrete_set)
    lambda{@sa.scaling_method = :blah}.should raise_error
  end
  
  it "should make repository available and adjustable" do
    @sa.repository.should eql(@sa)
    @a = Array.new
    @sa.repository = @a
    @sa.repository.should eql(@a)
  end
  
  # These are fuzzy in my mind...
  it "should have an append method" do
    @sa << 1
    @sa.push(2)
    @sa.repository.should eql([1,2])
  end
end
