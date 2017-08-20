require_relative 'node'
require 'pry'

class Tree
  attr_accessor :head
  
  def initialize
    @head = nil
  end
end