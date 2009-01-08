require 'rubygems'
require 'fastercsv'

module SVM::Transformer #:nodoc:
  class CSV #:nodoc:
        
    class << self
      def instance(filename)
        @@inst ||= {}
        @@inst[filename] ||= new
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
    
    attr_accessor :contents, :dictionary
  end
end
