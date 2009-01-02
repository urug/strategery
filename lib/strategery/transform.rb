module SVM #:nodoc:
  module Transform #:nodoc:
    
  end
end

Dir.glob("#{File.dirname(__FILE__)}/transform/**/*.rb").each { |file| require file }
