require 'spec_helper'

describe SVM::Transform do
end

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
