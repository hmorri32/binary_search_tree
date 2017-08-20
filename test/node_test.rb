require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/node'

class NodeTest < Minitest::Test
  def setup
    @node = Node.new(10, "sharknado")
  end

  def test_node_exists
    assert @node
  end
  
  def test_node_instance
    assert_instance_of Node, @node
  end

  def test_node_has_no_branches
    assert_nil @node.left
    assert_nil @node.right
  end

  def test_node_has_no_depth
    assert_equal 0, @node.depth
  end

  def test_node_initialized_with_data
    assert_equal 10, @node.score
    assert_equal 'sharknado', @node.title
  end

  def test_initialized_movie_obj
    obj = {"sharknado"=>10}
    assert_equal obj, @node.movie_obj
  end
end
