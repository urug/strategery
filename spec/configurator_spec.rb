# Just a note, this is more of an integration spec than anything else.
# It makes sure we can use a configuration that looks something like: 
# SVM::Configurator.run do |svm|
#   svm.default_transformer = SVM::Transformer.new{:labels => :label}
# end
require File.dirname(__FILE__) + '/spec_helper'

include SVM

describe "Configurator.run" do
  
  it "should take and run a block" do
    lambda{Configurator.run {1 + 1}}.should_not raise_error
    Configurator.run {1 + 1}.should eql(2)
  end
  
  it "should be able to set the default transformer" do
    transformer = Transformer::CSV.new
    Configurator.run {|svm| svm.default_transformer = transformer}
    SVM.default_transformer.should eql(transformer)
  end
  
  it "should be able to set the default repository" do
    repository = Repository::Array.new
    Configurator.run {|svm| svm.default_repository = repository}
    SVM.default_repository.should eql(repository)
  end
  
end

