# This uses RBTree, more specifically MultiRBTree.  That means that we
# are storing this data in a fairly efficient manner and that we can
# have multiple versions of each key. 
# Usage: 
# r = RBTreeRepository.new
# r[true] = [patthern]
class RBTreeRepository
  
  include Math

  require 'rubygems'
  require 'rbtree'
  require 'matrix'
  
  def initialize(scaling_method=:default_set)
    @scaling_method = scaling_method
  end

  def []=(k,v)
    @dirty = true
    repository[k] = infer(v)
  end

  def scale
    scaled_repository = RBTreeRepository.new
    self.each {|k,v| scaled_repository[k] = scaled_value(v)}
    scaled_repository
  end

  def mean
    @mean = nil if @dirty
    @mean ||= (sum / repository.size.to_f)
    @dirty = false
    @mean
  end

  def repository
    @repository ||= MultiRBTree.new
  end

  IsBoolean = /t|f|true|false|1|0|yes|y|no|n/
  class BooleanConverter
    
    IsTrue = /t|true|1|yes|y/
    IsFalse = /f|false|0|no|n/
    
    class << self
      # Converts to 1, -1, or 0 if unknown
      def convert(v)
        case v
        when IsTrue
          1
        when IsFalse
          -1
        else
          0
        end
      end
      
    end
  end
  
  private
  
    # Infers some classes that offer fewer suprises, such as an Array is transformed into a Vector
    def infer(v)
      case v
      when Array
        Vector.[](*v)
      when Numeric, Vector
        v
      when IsBoolean
        BooleanConverter.convert(v)
      else
        raise ArgumentError, 
          "Need to add some more conversions, such as for hierarchal data, a dictionary analysis, etc."
      end
    end
    
    def method_missing(name, *args, &block)
      block_given? ? repository.send(name, *args, &block) : repository.send(name, *args)
    end

    def sigmoid(v)
      1 / (1 + E ** -v)
    end
  
    # What's the name of this?  Continuous from -1 to 1, sigmoidal.
    def default_set(v)
      (sigmoid(v) * 2) - 1
    end
    
    def scaled_value(v)
      self.send(@scaling_method, (v - mean))
    end
    
    # Sets values to -1, 0, or 1
    def discrete_set(v)
      sig_val = sigmoid(v)
      ret = if sig_val <= 0.25
        -1
      elsif sig_val >= 0.75
        1
      else
        0
      end
    end
    
    def sum
      constrain(self.values.sum)
    end
    
    # Keeps divisible outputs
    def constrain(v)
      case v
      when Vector
        v.to_a
      else
        v
      end
    end
    
    def span
      true_max - true_min
    end
  
    def true_min
      repository.values.min
    end
  
    def true_max
      repository.values.max
    end

end