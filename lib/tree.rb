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

  def right_node?(score, node)
    node.score < score && node.right
  end
  
  def left_node?(score, node)
    node.score > score && node.left
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

  def depth_of(score, node = @head)
    return node.depth if node.score === score

    if right_node?(score, node)
      depth_of(score, node.right)
    elsif left_node?(score, node)
      depth_of(score, node.left)
    else
      nil
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
    in_order.push(sort(node.left)) unless node.left.nil?
    in_order.push(node.movie_obj)
    in_order.push(sort(node.right)) unless node.right.nil?
    in_order.flatten
  end

  def load(file)
    total = 0
    File.read(file).each_line do |movie|
      clean = format_flick(movie)
      insert_loaded_movie(clean)
      total += 1
    end
    total
  end

  def format_flick(movie)
    movie.strip.split(", ")      
  end

  def insert_loaded_movie(movie)
    score = movie.first.to_i
    title = movie.last
    insert(score, title) 
  end
end