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

    if node.score < score && node.right
      include?(score, node.right) 
    elsif node.score > score && node.left
      include?(score, node.left)
    else
      return false
    end
  end

  def depth_of(score, node = @head)
    return node.depth if node.score === score

    if node.score < score && node.right
      depth_of(score, node.right)
    elsif node.score > score && node.left
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

  def sort
    # sort pls
  end
end