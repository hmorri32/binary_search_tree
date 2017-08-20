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

  def test_tree_has_no_head
    assert_nil @tree.head
  end

  def test_can_insert_movie
    @tree.insert(20, 'cool movie')
    assert_equal 20, @tree.head.score
    assert_equal 'cool movie', @tree.head.title
  end

  def test_depth_zero_after_insertion
    @tree.insert(20, 'cool movie')
    assert_equal 20, @tree.head.score
    assert_equal 0, @tree.head.depth
  end


end
