module SVM #:nodoc:
  module Repository #:nodoc:
    # Kind of weird.  Want to just store this in SVM, but want to know how
    # to find the configuration. 
    class << SVM
      def repository=(obj)
        @@repository = obj
      end
      alias :default_repository= :repository=
      
      def repository
        @@repository
      end
      alias :default_repository :repository
    end
  end
end

Dir.glob("#{File.dirname(__FILE__)}/repository/**/*.rb").each { |file| require file }

