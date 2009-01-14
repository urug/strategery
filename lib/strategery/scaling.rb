# It may just be simpler to do this per repository.

require 'activesupport'

module SVM #:nodoc:

  # This is a module for converting a repository into a scalable
  # repository, I.e., all values are scaled for SVM, between -1 and 1.
  # This makes the resultant model much more effective. 
  module Scaling #:nodoc:
  
    # To make this more generally useful, will use @base to refer to the target class.
    def self.included(base)
      @base = base
    end

    # Needed to know what method to scale with.  The various methods will
    # produce either a discrete set {-1, 0, 1} (:discrete_set), a sigmoid
    # value (continuous from 0 to 1, :sigmoid), or a continuous value from -
    # 1 to 1 (:default_set).  The default is of course :default_set. 
    def scaling_method
      @scaling_method ||= :default_set
    end
    
    def scaling_method=(meth)
      raise ArgumentError, "Must provide an available method" unless 
        self.methods.include?(meth.to_s) ||
        self.private_methods.include?(meth.to_s)
      @scaling_method = meth
    end
    
    # Used in referring to either the base class itself (default), or some
    # collection the the base class can use. 
    def repository
      @repository ||= self
    end
    
    def repository=(obj)
      @repository = obj
    end

    # This doesn't always make sense, so be careful here.
    def []=(k,v)
      # This is important, because it lets us filter the input and lazy-
      # evaluate some of the more computationally expensive methods (such as
      # mean). 
      @dirty = true
      repository[k] = infer(v)
    end
    
    # OK, this is a little tricky.  I couldn't figure out how to involve
    # <<_some_definition, so:
    # 
    # 1) Make sure there is a << and push method available on the repository
    # 2) Write an override for this method
    # 3) Chain the methods (saves a few steps)
    # 4) Alias << to push 
    # class_eval {
    #   def <<(other); end
    # } unless self.instance_methods.include?('<<')
    # 
    # class_eval {
    #   def push(other); end
    # } unless self.instance_methods.include?('push')
    # 
    # def push_with_cache_override(v)
    #   @dirty = true
    #   repository.push_without_cache_override(infer(v))
    # end
    # alias_method_chain :push, :cache_override
    # alias :<< :push

    def base
      @base ||= self.class
    end
    
    def scale
      scaled_repository = base.new
      self.each {|k,v| scaled_repository[k] = scaled_value(v)}
      scaled_repository
    end

    def mean
      @mean = nil if @dirty
      @mean ||= (sum / repository.size.to_f)
      @dirty = false
      @mean
    end
  
    def method_missing(name, *args, &block)
      block_given? and repository != self ? repository.send(name, *args, &block) : repository.send(name, *args)
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

      # Infers some classes that offer fewer suprises, e.g. an Array is
      # transformed into a Vector because an average set of values should add
      # the components of each pattern. 
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

      # Just a standard sigmoid function
      def sigmoid(v)
        1 / (1 + E ** -v)
      end

      # What's the name of this?  Continuous from -1 to 1, sigmoidal.
      def default_set(v)
        (sigmoid(v) * 2) - 1
      end

      # The generic call to scale a value, using @scaling_method to direct
      # this to various scalers. 
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
        # This is a tricky assumption here: the underlying class needs to
        # implement first.  If this gets in the way, you may want to implement sum another way.
        repository.class_eval{
          def repository.sum
            return 0 unless first
            klass = first.class
            constrain(inject(klass.new) {|sum, x| sum += x})
          end
        } unless repository.class.instance_methods.include?('sum')
        repository.sum
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

  end
end
