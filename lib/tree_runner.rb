require_relative 'node'
require_relative 'tree'
require 'pry'


tree = Tree.new

tree.insert(25, "Zoolander")
tree.insert(10, "This is Spinal Tap")
tree.insert(14, "Caddyshack")
tree.insert(30, "Monty Python")
# tree.depth_of(10)