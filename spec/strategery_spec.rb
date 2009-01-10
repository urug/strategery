require File.dirname(__FILE__) + '/spec_helper'

describe "Initialization" do

  it "should setup a config string from a file, if available" do
    SVM.instance_eval {@config = nil}
    File.should_receive(:read).with('config.rb').and_return('1+1')
    SVM.config
    SVM.instance_eval {@config}.should eql('1+1')
  end
  
  it "should call the SVM::Configurator" do
    SVM::Configurator.should_receive(:run)
    SVM.instance_eval {@config = nil}
    SVM.config
  end
  
  it "should require rubygems" do
    self.should be_respond_to(:gem)
  end

  it "should require yaml" do
    self.should be_respond_to(:to_yaml)
  end
  
end

