require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/tree'

class TreeTest < Minitest::Test
  def setup
    @tree = Tree.new
  end

  def test_tree_exists
    assert @tree
  end

  def test_tree_instance
    assert_instance_of Tree, @tree
  end

  def test_tree_has_no_head
    assert_nil @tree.head
  end

  def test_can_insert_movie
    @tree.insert(20, 'cool movie')
    assert_equal 20, @tree.head.score
    assert_equal 'cool movie', @tree.head.title
  end

  def test_depth_zero_after_first_insertion
    @tree.insert(20, 'cool movie')
    assert_equal 20, @tree.head.score
    assert_equal 0, @tree.head.depth
  end

  def test_depth_after_two
    @tree.insert(20, 'sharknado')    
    @tree.insert(25, 'lost')
    assert_equal 1, @tree.head.right.depth
  end

  def test_cant_insert_same_score
    @tree.insert(20, 'sharknado')    
    @tree.insert(20, 'lost')
    assert_nil @tree.head.left
    assert_nil @tree.head.right
  end
end
