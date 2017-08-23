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
    
    if right_node?(score, node)
      include?(score, node.right) 
    elsif left_node?(score, node)
      include?(score, node.left)
    else
      return false
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

    if right_node?(score, node)
      depth_of(score, node.right)
    elsif left_node?(score, node)
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
    (child / total.to_f * 100).to_i
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
    leaf?(node) ? node.depth + 1 : traverse(left, right)
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

  def delete_left(score, node)
    child = node.left
    if wrong_child?(child, score)
      delete(score, child)
    elsif the_child?(child, score)
      if leaf?(child)
        node.left  = nil
        node.right = nil
      elsif child.left && child.right 
        'cry'
      elsif child.left
        node.left = child.left
      elsif child.right
        node.left = child.right
      end
    end
  end

  def delete_right(score, node) 
    child = node.right 
    if wrong_child?(child, score) 
      delete(score, child)
    elsif the_child?(child, score)
      if leaf?(child)
        node.right = nil 
        node.left  = nil
      elsif child.right && child.left 
        'cry'
      elsif child.right
        node.right = child.right
      elsif child.left
        node.right = child.left
      end
    end
  end

  def delete_head
    self.head = nil    
  end

  def delete(score, node = @head)
    delete_head if score == @head.score 
    score < node.score ? delete_left(score, node) : delete_right(score, node)   
  end
end
