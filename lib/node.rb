class Node
  attr_accessor :score, 
                :title, 
                :movie_obj,
                :right,
                :left,
                :depth
  
  def initialize(score, title)
    @score     = score
    @title     = title
    @movie_obj = { title => score }
    @right     = nil
    @left      = nil
    @depth     = 0
  end

  def insert_node(score, title)

  end
end