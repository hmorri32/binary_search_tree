require_relative 'node'
require 'pry'

class Tree
  attr_accessor :head
  
  def initialize
    @head = nil
  end

  def insert(score, title) #cant read this. 
    if head.nil? 
      @head = Node.new(score, title)
      head.depth
    else
      @head.insert_node(score, title)
    end
  end

  def traverse_left?
  end

  def traverse_right?
  end

  def include?(score, node = @head)
    return true if node.score == score

    if (node.score < score) && node.right
      include?(score, node.right) # pass score node.right

    elsif (node.score > score) && node.left
      include?(score, node.left)
    else
      return false
    end
  end

  def depth_of(score, node = @head)
    # TODO

    if @head.score > score && @head.left
      
    end

    if @head.score < score && head.right

    end

  end
end
