require_relative 'node'
require_relative 'tree'
require 'pry'

tree = Tree.new
tree.insert(64, "Zoolander")
tree.insert(95, "This is Spinal Tap")
# tree.insert(74, "Caddyshack")
# tree.insert(98, "Monty Python")
# tree.insert(12, "nested dirty")

tree.delete(95)
binding.pry