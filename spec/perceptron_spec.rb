require File.dirname(__FILE__) + '/spec_helper'

include SVM

describe Perceptron do
  
  it "should have a sigmoid perceptron" do
    Perceptron.new(:sigmoid).map([-1,0,1]).should eql([0,0,1])
  end
  
  it "should have a truth perceprton" do
    Perceptron.new(:truth).map([nil, false, 1]).should eql([0,0,1])
  end
  
  it "should take a block as a perceptron" do
    p = Perceptron.new {|x| x > 2.5 ? 1 : 0}
    p.map([-1,0,2.5,5]).should eql([0,0,0,1])
  end
end

