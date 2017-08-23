require_relative 'node'
require_relative 'tree'
require 'pry'

tree = Tree.new
tree.insert(10, 'root')
tree.insert(20, 'right')
tree.insert(30, 'right')

tree.delete(20)
binding.pry