# Example: Perceptron.new(:sigmoid).map(-1,0,1) # => [0,0,1]
# Perceptron.new {|x| doc.include?(x) ? 1 : 0} 
class Perceptron
  require 'rubygems'
  require 'activesupport'
  
  class TruthPerceptron
    def check(item)
      item ? 1 : 0
    end
  end
  
  class SigmoidPerceptron
    def check(item)
      item > 0 ? 1 : 0
    end
  end
  
  attr_accessor :perceptron
  def initialize(name=nil, &block)
    @perceptron = infer_perceptron(name)
    @perceptron ||= block if block
    @perceptron ||= SigmoidPerceptron.new
  end
  
  def map(a)
    if perceptron.is_a?(Proc)
      a.map{ |x| perceptron.call(x) }
    else
      a.map{ |x| perceptron.check(x) }
    end
  end

  # Takes an argument like :sigmoid
  def infer_perceptron(name=nil)
    return false unless name
    ("Perceptron::" + name.to_s.classify + "Perceptron").constantize.new
  end
  private :infer_perceptron
  
end
