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
end