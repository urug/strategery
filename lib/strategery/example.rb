  labels = [1, 1, 0, 1, 1, 0, 0]
 
  documents = [
    %w[FREE NATIONAL TREASURE],   	# Spam
    %w[FREE TV for EVERY visitor],	# Spam
    %w[Peter and Stewie are hilarious], # OK
    %w[AS SEEN ON NATIONAL TV],		# SPAM
    %w[FREE drugs],			# SPAM
    %w[New episode rocks, Peter and Stewie are hilarious], # OK
    %w[Peter is my fav!]		# OK
    # ...
  ]
 
  test_labels = [1, 0, 0]
 
  test_documents = [
    %w[FREE lotterry for the NATIONAL TREASURE !!!], # Spam
    %w[Stewie is hilarious],		# OK
    %w[Poor Peter ... hilarious],	# OK
    # ...
  ]
 
dictionary = (documents+test_documents).flatten.uniq
feature_vectors = documents.map { |doc| dictionary.map{|x| doc.include?(x) ? 1 : 0} }
test_vectors = test_documents.map { |doc| dictionary.map{|x| doc.include?(x) ? 1 : 0} }

require 'SVM' 
include SVM
 
# Define kernel parameters -- we'll stick with the defaults
pa = Parameter.new
pa.C = 100
pa.svm_type = NU_SVC
pa.degree = 1
pa.coef0 = 0
pa.eps= 0.001
 
sp = Problem.new
 
# Add documents to the training set
labels.each_index { |i| sp.addExample(labels[i], feature_vectors[i]) }
 
# We're not sure which Kernel will perform best, so let's give each a try
kernels = [ LINEAR, POLY, RBF, SIGMOID ]
kernel_names = [ 'Linear', 'Polynomial', 'Radial basis function', 'Sigmoid' ]
 
kernels.each_index { |j|
  # Iterate and over each kernel type
  pa.kernel_type = kernels[j]
  m = Model.new(sp, pa)
  errors = 0
 
  # Test kernel performance on the training set
  labels.each_index { |i|
    pred, probs = m.predict_probability(feature_vectors[i])
    puts "Prediction: #{pred}, True label: #{labels[i]}, Kernel: #{kernel_names[j]}"
    errors += 1 if labels[i] != pred
  }
  puts "Kernel #{kernel_names[j]} made #{errors} errors on the training set"
 
  # Test kernel performance on the test set
  errors = 0
  test_labels.each_index { |i|
    pred, probs = m.predict_probability(test_vectors[i])
    puts "\\t Prediction: #{pred}, True label: #{test_labels[i]}"
    errors += 1 if test_labels[i] != pred
  }
 
  puts "Kernel #{kernel_names[j]} made #{errors} errors on the test set \\n\\n"
}
 
