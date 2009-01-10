module SVM #:nodoc:
  module Transformer #:nodoc:
    # Kind of weird.  Want to just store this in SVM, but want to know how
    # to find the configuration. 
    class << SVM
      def transformer=(obj)
        @@transformer = obj
      end
      alias :default_transformer= :transformer=
      
      def transformer
        @@transformer
      end
      alias :default_transformer :transformer
    end
  end
end

Dir.glob("#{File.dirname(__FILE__)}/transformer/**/*.rb").each { |file| require file }

# def dictionary_size(reset=false)
#   @dictionary_size = nil if reset
#   @dictionary_size ||= dictionary.size
# end
# 
# def dictionary(reset=false)
#   @dictionary ||= []
# end
# 
# class Dictionary
#   include Enumerable
#   def initialize
#     @items = []
#   end
#   def <<(item)
#     @items << item
#   end
# end
# 
# 
#   labels = [1, 1, 0, 1, 1, 0, 0]
#  
#   documents = [
#     %w[FREE NATIONAL TREASURE],     # Spam
#     %w[FREE TV for EVERY visitor],  # Spam
#     %w[Peter and Stewie are hilarious], # OK
#     %w[AS SEEN ON NATIONAL TV],   # SPAM
#     %w[FREE drugs],     # SPAM
#     %w[New episode rocks, Peter and Stewie are hilarious], # OK
#     %w[Peter is my fav!]    # OK
#     # ...
#   ]
#  
# # Test set ...
# # ----------------------------------------------------------
#   test_labels = [1, 0, 0]
#  
#   test_documents = [
#     %w[FREE lotterry for the NATIONAL TREASURE !!!], # Spam
#     %w[Stewie is hilarious],    # OK
#     %w[Poor Peter ... hilarious], # OK
#     # ...
#   ]
#  
# # Build a global dictionary of all possible words
# dictionary = (documents+test_documents).flatten.uniq
# puts "Global dictionary: \\n #{dictionary.inspect}\\n\\n"
#  
# # Build binary feature vectors for each document 
# #  - If a word is present in document, it is marked as '1', otherwise '0'
# #  - Each word has a unique ID as defined by 'dictionary' 
# feature_vectors = documents.map { |doc| dictionary.map{|x| doc.include?(x) ? 1 : 0} }
# test_vectors = test_documents.map { |doc| dictionary.map{|x| doc.include?(x) ? 1 : 0} }

