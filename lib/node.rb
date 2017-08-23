require 'pry'

class Node
  attr_accessor :score, 
                :title, 
                :movie_obj,
                :left,
                :right,
                :depth
  
  def initialize(score, title)
    @score     = score
    @title     = title
    @movie_obj = { title => score }
    @left      = nil
    @right     = nil
    @depth     = 0
  end

  def insert_node(score, title)
    return if score == @score
    score < @score ? create_left(score, title) : create_right(score, title)
  end

  def create_left(score, title)
    if @left.nil?
       @left       = Node.new(score, title)
       @left.depth = depth + 1
    else 
      @left.insert_node(score, title)
    end
  end

  def create_right(score, title)
    if @right.nil?
       @right       = Node.new(score, title)
       @right.depth = depth + 1
    else
      @right.insert_node(score, title)
    end
  end
end