require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/binary_search_tree'

class BinarySearchTreeTest < Minitest::Test
  def setup
    @tree = BinarySearchTree.new
  end

  def test_tree_exists
    assert @tree
  end

  def test_tree_instance
    assert_instance_of BinarySearchTree, @tree
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

    refute @tree.include?(10)
    assert @tree.include?(20)
    assert @tree.include?(40)
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

  def test_format
    string    = "75, French Dirty"    
    formatted = @tree.format(string)

    assert_equal ["75", "French Dirty"], formatted
  end

  def test_load_file_inserts_movies_returns_count
    assert_equal 99, @tree.load('lib/movies.txt')
  end

  def test_load_different_file
    assert_equal 10, @tree.load('lib/comedies.txt')
  end

  def test_load_no_duplicates
    @tree.load('lib/duplicates.txt')

    assert_equal "Airplane", @tree.head.title
    assert_nil @tree.head.left
    assert_nil @tree.head.right
  end

  def test_depth_sort_returns_nodes_at_depth
    @tree.insert(97, "Airplane")

    assert_equal ({"Airplane"=>97}), @tree.depth_sort(0)[0].movie_obj
  end

  def test_health_returns_multidemensional_arr
    @tree.insert(97, "Airplane")
    health = @tree.health(0)

    assert_equal [[97, 1, 100]], health
  end

  def test_health_with_loaded_tree
    @tree.insert(64, "Zoolander")
    @tree.insert(95, "This is Spinal Tap")
    @tree.insert(74, "Caddyshack")
    @tree.insert(98, "Monty Python")
    @tree.insert(12, "nested dirty")

    root  = @tree.health(0)
    one   = @tree.health(1)
    two   = @tree.health(2)

    assert_equal [[64, 5, 100]], root
    assert_equal [[12, 1, 20], [95, 3, 60]], one
    assert_equal [[74, 1, 20], [98, 1, 20]], two
  end

  def test_health_empty_node 
    @tree.insert(64, "Zoolander")
    root   = @tree.health(0)
    numpty = @tree.health(2)

    assert_equal [[64, 1, 100]], root
    assert_equal [], numpty
  end

  def test_health_spec_example
    @tree.insert(98, "Animals United")
    @tree.insert(58, "Armageddon")
    @tree.insert(36, "Bill & Ted's Bogus Journey")
    @tree.insert(93, "Bill & Ted's Excellent Adventure")
    @tree.insert(86, "Charlie's Angels")
    @tree.insert(38, "Charlie's Country")
    @tree.insert(69, "Collateral Damage")

    assert_equal [[98, 7, 100]], @tree.health(0)
    assert_equal [[58, 6, 85]], @tree.health(1)
    assert_equal [[36, 2, 28], [93, 3, 42]], @tree.health(2)
  end

  def test_percent_method
    assert_equal 50, @tree.percentage(50, 100)
    assert_equal 75, @tree.percentage(3, 4)
  end

  def test_leaves_spec_example
    @tree.insert(98, "Animals United")
    @tree.insert(58, "Armageddon")
    @tree.insert(36, "Bill & Ted's Bogus Journey")
    @tree.insert(93, "Bill & Ted's Excellent Adventure")
    @tree.insert(86, "Charlie's Angels")
    @tree.insert(38, "Charlie's Country")
    @tree.insert(69, "Collateral Damage")

    assert_equal 2, @tree.leaves
  end

  def test_height_zero
    assert_equal 0, @tree.height
  end

  def test_height_spec_example
    @tree.insert(98, "Animals United")
    @tree.insert(58, "Armageddon")
    @tree.insert(36, "Bill & Ted's Bogus Journey")
    @tree.insert(93, "Bill & Ted's Excellent Adventure")
    @tree.insert(86, "Charlie's Angels")
    @tree.insert(38, "Charlie's Country")
    @tree.insert(69, "Collateral Damage")

    assert_equal 5, @tree.height
  end

  def test_delete_root
    @tree.insert(15, 'root')
    @tree.delete(15)
    
    assert_nil @tree.head
  end

  def test_delete_min_leaf
    @tree.insert(15, 'root')
    @tree.insert(10, 'left')
    @tree.insert(5, 'leaf')

    assert @tree.head.left.left

    @tree.delete(5)

    refute @tree.head.left.left
  end

  def test_delete_max_leaf 
    @tree.insert(10, 'root')
    @tree.insert(20, 'right')
    @tree.insert(30, 'leaf')

    assert @tree.head.right.right

    @tree.delete(30)

    refute @tree.head.right.right
  end

  def test_delete_right_mid_right_child
    @tree.insert(10, 'root')
    @tree.insert(20, 'right')
    @tree.insert(30, 'leaf')

    assert_equal 20, @tree.head.right.score
    assert @tree.head.right.right

    @tree.delete(20) 

    assert_equal 30, @tree.head.right.score
    refute @tree.head.right.right
  end
  
  def test_delete_right_mid_w_left_child
    @tree.insert(10, 'root')
    @tree.insert(20, 'mid')
    @tree.insert(15, 'leaf left')
    assert_equal 20, @tree.head.right.score

    @tree.delete(20)

    assert_equal 15, @tree.head.right.score
  end

  def test_delete_left_mid_left_child
    @tree.insert(15, 'root')
    @tree.insert(10, 'left')
    @tree.insert(5, 'leaf')

    assert_equal 10, @tree.head.left.score
    assert @tree.head.left.left
    
    @tree.delete(10)
    assert_equal 5, @tree.head.left.score
    refute @tree.head.left.left
   end

   def test_delete_left_mid_right_child 
    @tree.insert(15, 'root')
    @tree.insert(10, 'left')
    @tree.insert(11, 'leaf')
    
    assert_equal 10, @tree.head.left.score 

    @tree.delete(10)

    assert_equal 11, @tree.head.left.score
  end

   def test_delete_with_two_children_left_branch
    @tree.insert(8, 'root')
    @tree.insert(3 ,'left')
    @tree.insert(1, 'left leaf')
    @tree.insert(6 ,'right')

    assert_equal 'cry', @tree.delete(3)
  end

   def test_delete_with_two_children_right_branch
    @tree.insert(7, 'root')
    @tree.insert(12 ,'right')
    @tree.insert(9, 'left leaf')
    @tree.insert(15 ,'right')

    assert_equal 'cry', @tree.delete(12)
  end
end


