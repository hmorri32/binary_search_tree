require_relative 'node'
require 'pry'

class Tree
  attr_accessor :head
  
  def initialize
    @head = nil
  end

  def insert(score, title)
    head.nil? ? (@head = Node.new(score, title); head.depth) 
              :  @head.insert_node(score, title)
  end

  def include?(score)
    return true if @head.score == score

    if (@head.score < score) && @head.right != nil
      include?(score)
    elsif (@head.score > score) && @head.left != nil
      include?(score)
    else
      return false
    end
  end
end