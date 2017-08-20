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

  def test_node_has_data
    assert_equal 10, @node.score
    assert_equal 'sharknado', @node.title
  end

  def test_movie_obj
    obj = {"sharknado"=>10}
    assert_equal obj, @node.movie_obj
  end
end
