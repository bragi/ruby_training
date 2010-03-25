#!/usr/bin/env ruby

# Accepts a list of integers, prints out values of their squares and sum of
# squares.
#
# Usage:
#
#     ruby t2 2
#
# prints: 
#
#     Sum: 2
#     Squares: 4
#     Sum of squares: 4
#
# Advanced usage:
#
#     ruby t2 1 2 3 4 5 6
#
# prints: 
#
#     Sum: 21
#     Squares: 1 4 9 16 25 36
#     Sum of squares: 91

class Array
  def sum
    inject(0) do |result, i|
      result += i.to_i
    end
  end
end

class Squares
  def initialize(args)
    @array = Array.new(args)
  end

  def to_s
    out = ''
    out << "Sum: #{sum.to_s}\n"
    out << "Squares: #{squares.join(' ')}\n"
    out << "Sum of squares: #{squares.sum.to_s}\n"
  end

  def sum
    return @array.sum
  end
  
  def squares
    @array.map { |x| x.to_i**2 }
  end
end

puts Squares.new(ARGV) or exit(0) unless ARGV.empty?

require 'test/unit'

class SquaresTest < Test::Unit::TestCase
  def test_create_accepts_single_item_array
    Squares.new(%w(1))
  end

  def test_create_accepts_multiple_items_array
    Squares.new(%w(1 2 3 4 5))
  end
  
  def test_sum_returns_sum_of_array_items
    assert_equal 15, Squares.new(%w(1 2 3 4 5)).sum
  end
  
  def test_return_list_of_squares
    assert_equal [1, 4, 9, 16, 25], Squares.new(%w(1 2 3 4 5)).squares
  end
  
  def test_return_sum_of_squares
    assert_equal 55, Squares.new(%w(1 2 3 4 5)).squares.sum
  end
  
  def test_have_string_representation
    assert_equal "Sum: 15
Squares: 1 4 9 16 25
Sum of squares: 55
", Squares.new(%w(1 2 3 4 5)).to_s
  end
end
