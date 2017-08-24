require_relative 'node'
require 'pry'

class Tree
  attr_accessor :head
  
  def initialize
    @head = nil
  end

  def insert(score, title)
    if head.nil? 
      @head = Node.new(score, title)
      head.depth
    else
      @head.insert_node(score, title)
    end
  end

  def include?(score, node = @head)
    return true if node.score == score
    case
    when right_node?(score, node)
      include?(score, node.right) 
    when left_node?(score, node)
      include?(score, node.left)
    else
      false
    end
  end
  
  def right_node?(score, node)
    node.score < score && node.right
  end
  
  def left_node?(score, node)
    node.score > score && node.left
  end

  def depth_of(score, node = @head)
    return node.depth if node.score == score
    case
    when right_node?(score, node)
      depth_of(score, node.right)
    when left_node?(score, node)
      depth_of(score, node.left)
    end
  end

  def max(node = @head)
    node.right.nil? ? node.movie_obj : max(node.right)
  end

  def min(node = @head)
    node.left.nil? ? node.movie_obj : min(node.left)
  end

  def sort(node = @head)
    in_order = []
    in_order.push(sort(node.left))  unless node.left.nil?
    in_order.push(node.movie_obj)
    in_order.push(sort(node.right)) unless node.right.nil?
    in_order.flatten
  end

  def load(file, total = 0)
    File.read(file).each_line do |movie|
      clean = format(movie)
      insert_loaded_movie(clean)
      total += 1
    end
    total
  end

  def format(movie)
    movie.strip.split(", ")      
  end

  def insert_loaded_movie(movie)
    score = movie.first.to_i
    title = movie.last
    insert(score, title) 
  end

  def health(depth, node = @head)
    sorted     = depth_sort(depth)
    node_tally = sort(node).length
    sorted.map do |node|
      score    = node.score
      children = sort(node).length
      percent  = percentage(children, node_tally)
      [score, children, percent]
    end
  end

  def percentage(child, total)
    (child.to_f / total * 100).floor
  end

  def depth_sort(depth, node = @head)
    at_depth = []
    at_depth.push(node) if node.depth == depth
    at_depth.push(depth_sort(depth, node.left))  unless node.left.nil?
    at_depth.push(depth_sort(depth, node.right)) unless node.right.nil?
    at_depth.flatten
  end

  def leaves(node = @head, pile = 0)
    pile += 1 if leaf?(node)
    pile += leaves(node.left)  if node.left
    pile += leaves(node.right) if node.right
    pile
  end

  def leaf?(node)
    node.left.nil? && node.right.nil?
  end

  def height(node = @head)
    return 0 if node.nil?
    left  = height(node.left)
    right = height(node.right)
    if leaf?(node)
      node.depth + 1
    else
      traverse(left, right)
    end
  end

  def delete(score, node = @head)
    delete_head if score == @head.score 
    if score < node.score
      delete_left(score, node)
    else 
      delete_right(score, node)
    end 
  end

  def delete_left(score, node)
    child = node.left
    delete_traverse(child, score)

    if the_child?(child, score)
      case 
      when leaf?(child)
        delete_leaf(node) 
      when child.left && child.right
        delete_two_children
      when child_left?(child)
        node.left = child.left
      when child_right?(child)
        node.left = child.right
      end  
    end  
  end  

  def delete_right(score, node) 
    child = node.right 
    delete_traverse(child, score)

    if the_child?(child, score)
      case
      when leaf?(child)
        delete_leaf(node)
      when child.right && child.left
        delete_two_children
      when child_right?(child)
        node.right = child.right            
      when child_left?(child) 
        node.right = child.left
      end
    end
  end

  def delete_leaf(node)
    node.right, node.left = nil
  end

  def child_right?(child)
    child.right
  end

  def child_left?(child)
    child.left
  end

  def delete_head
    self.head = nil    
  end

  def traverse(left, right)
    right > left ? right : left
  end

  def wrong_child?(child, score)
    child && child.score != score
  end

  def the_child?(child, score)
    child && child.score == score
  end
  
  def delete_traverse(child, score)
    if wrong_child?(child, score) 
      delete(score, child)
    end
  end

  def delete_two_children
     'cry'
  end
end