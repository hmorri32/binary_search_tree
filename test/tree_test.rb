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
    @tree.insert(25, 'lebowski')

    assert_equal 1, @tree.head.right.depth
  end

  def test_insert_returns_depth
    assert_equal 0, @tree.insert(20, 'coool')
    assert_equal 1, @tree.insert(10, 'coool')
    assert_equal 2, @tree.insert(8, 'another')
    assert_equal 2, @tree.insert(12, 'another')
  end

  def test_cant_insert_same_score
    @tree.insert(20, 'sharknado')    
    @tree.insert(20, 'lost')

    assert_equal "sharknado", @tree.head.title
    assert_nil @tree.head.left
    assert_nil @tree.head.right
  end

  def test_include_returns_bool
    @tree.insert(20, 'sharknado')    
    @tree.insert(25, 'lebowski')
    @tree.insert(40, 'cool')

    assert_equal false, @tree.include?(10)
    assert_equal true, @tree.include?(20)
    assert_equal true, @tree.include?(40)
  end

  def test_depth_of_one_movie
    @tree.insert(30, 'airplane')

    assert_equal 0, @tree.depth_of(30)
  end

  def test_depth_heaps_of_flicks
    @tree.insert(64, "Zoolander")
    @tree.insert(95, "This is Spinal Tap")
    @tree.insert(74, "Caddyshack")
    @tree.insert(98, "Monty Python")

    assert_equal 2, @tree.depth_of(98)
  end

  def test_depth_when_nil
    @tree.insert(64, "Zoolander")
    @tree.insert(95, "This is Spinal Tap")
    @tree.insert(74, "Caddyshack")
    @tree.insert(98, "Monty Python")

    assert_nil @tree.depth_of(100)
  end

  def test_find_max
    @tree.insert(64, "Zoolander")
    @tree.insert(95, "This is Spinal Tap")
    @tree.insert(74, "Caddyshack")
    @tree.insert(98, "Monty Python")
    max = {"Monty Python" => 98}

    assert_equal max, @tree.max 
  end

  def test_find_min
    @tree.insert(64, "Zoolander")
    @tree.insert(95, "This is Spinal Tap")
    @tree.insert(74, "Caddyshack")
    @tree.insert(98, "Monty Python")
    @tree.insert(12, "nested dirty")
    min = {"nested dirty" => 12}

    assert_equal min, @tree.min 
  end

  def test_sort_returns_movie_obj
    @tree.insert(64, "Zoolander")

    assert_equal ([{"Zoolander" => 64}]), @tree.sort
  end

  def test_sort_returns_sorted_jason
    @tree.insert(64, "Zoolander")
    @tree.insert(20, "Spinal Tap")

    assert_equal ([{"Spinal Tap" => 20},{"Zoolander" => 64}]), @tree.sort
  end

  def test_sort_five_returns_sorted_jason
    @tree.insert(64, "Zoolander")
    @tree.insert(95, "This is Spinal Tap")
    @tree.insert(74, "Caddyshack")
    @tree.insert(98, "Monty Python")
    @tree.insert(12, "nested dirty")
    expected = [{"nested dirty"=>12}, 
                {"Zoolander"=>64}, 
                {"Caddyshack"=>74}, 
                {"This is Spinal Tap"=>95}, 
                {"Monty Python"=>98}]

    assert_equal expected, @tree.sort
  end

  def test_format_flick
    string    = "75, French Dirty"    
    formatted = @tree.format_flick(string)
    
    assert_equal ["75", "French Dirty"], formatted
  end

  def test_load_file_inserts_movies_returns_count
    assert_equal 99, @tree.load('lib/movies.txt')
  end


end


