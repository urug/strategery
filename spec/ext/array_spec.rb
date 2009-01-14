require File.dirname(__FILE__) + '/../spec_helper'

describe Array do
  it "should allow scalar divison" do
    a = [2,4,6]
    (a / 2).should eql([1,2,3])
  end

end