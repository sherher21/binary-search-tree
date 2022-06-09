require_relative './binary_search_tree/node.rb'
require_relative './binary_search_tree/tree.rb'

tree = Tree.new((Array.new(15) { rand(1..100) }))
puts "Balanced = #{tree.balanced?}"
puts "Level Order = #{tree.level_order}"
puts "Preorder = #{tree.preorder}"
puts "Inorder = #{tree.inorder}"
puts "Postorder = #{tree.postorder}"
tree.insert(101)
tree.insert(121)
tree.insert(141)
tree.insert(161)
tree.insert(181)
tree.pretty_print
puts "Balanced after insert = #{tree.balanced?}"
puts "Rebalancing"
tree.rebalance
puts "Balanced = #{tree.balanced?}"
puts "Level Order = #{tree.level_order}"
puts "Preorder = #{tree.preorder}"
puts "Inorder = #{tree.inorder}"
puts "Postorder = #{tree.postorder}"
tree.pretty_print
