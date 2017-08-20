require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class TreeTest < Minitest::Test
  def test_cool
    c = 'ultra cool'
    assert_equal 'ultra cool', c
  end
end
