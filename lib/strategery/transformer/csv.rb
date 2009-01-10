# Use the FasterCSV interface better:
# convert to a hash
# user converters
# symbolize header
# allow options to be passed to FasterCSV
# 
# Add Amalgalite support

require 'rubygems'
require 'fastercsv'

module SVM::Transformer #:nodoc:
  class CSV
        
    class << self
      def instance(filename)
        @@inst ||= {}
        @@inst[filename] ||= new
      end
      
# There are a few things to consider here.  We are dealing with storing a
# hash of transformed files. We keep the instances of that data in class
# instances.  We should add streams and from-memory values to the mix.
# Add differentkinds of repositories.  Make an array the default.  Use
# RBtree and Amalgalite, for sure. This should make larger file
# processing faster.  So, there are many configuration considerations to
# work through.  Next, we need to put together the repositories, to make
# sure they're ready.  Next, I need to do a lot of end-to-end tests, to
# make sure I am slurping data out of something else in a Ruby-esque
# manner.  Finally, it's time to benchmark the work, to make sure that
# we understand why to use various types of input and repositories.  I'd
# like to make sure I can make everything work in the context of other
# algorithms, especially Agency. 
      
      # Send any args to the repository constructor as :args => [...]
      def repository=(filename, opts={}, &block)
        contents(filename).repository = opts.delete(:name) || ArrayRespository.new()
      end
      
      def repository(filename)
        contents(filename).repository
      end
      
      def contents(filename)
        instance(filename).contents ||= FasterCSV.open(filename).map {|x| x}
      end
      alias :load :contents
      
      def each_line(filename)
        contents(filename).each {|x| yield}
      end
      
      def create_dictionary(filename)
        instance(filename).dictionary ||= contents(filename).flatten.uniq
      end
      
    end
    
    attr_accessor :contents, :dictionary, :repository
  end
end
