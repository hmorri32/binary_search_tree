require_relative 'node'
require_relative 'binary_search_tree'
require 'pry'

tree = BinarySearchTree.new
tree.insert(10, 'root')
tree.insert(20, 'right')
tree.insert(30, 'right')

tree.delete(20)
binding.pry