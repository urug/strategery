require 'lib/strategery'
@rbtree = RBTreeRepository.new(:default_set)
@rbtree[1] = -100
@rbtree[1] = -10
@rbtree[1] = 0
@rbtree[1] = 10
@rbtree[1] = 100
puts @rbtree.scale.values.inspect