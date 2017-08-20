require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/tree'

class TreeTest < Minitest::Test
  def test_tree_exists
    tree = Tree.new
    assert tree
  end

  def test_tree_has_no_head
    tree = Tree.new
    assert_nil tree.head
  end


end
