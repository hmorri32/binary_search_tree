class Node
  attr_accessor :score, :title, :movie_obj
  
  def initialize(score, title)
    @score     = score
    @title     = title
    @movie_obj = { title => score }
  end
end