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
    sorted = []
    branch_sort(node, sorted)
    # sort pls
    # sorted.push(node.movie_obj)   if node.left.nil?
    # sorted.push(sort(node.left))  if !node.left.nil?
    # sorted.push(node.movie_obj)   if !sorted.include?(node.movie_obj)
    # sorted.push(sort(node.right)) if !node.right.nil?
    sorted
  end
  
  def branch_sort(node, arr)
    return if node.nil?
    branch_sort(node.left, arr)
    arr.push(node.movie_obj)
    branch_sort(node.right, arr)
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