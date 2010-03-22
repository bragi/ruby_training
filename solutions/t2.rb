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

class Squares
end

# Make sure RomanNumbers#convert! ends the program with exit()
puts Squares.new(ARGV) and exit(0) unless ARGV.empty?

require 'unit/test'

class SquaresTest < Test::Unit::TestCase
  def test_create_accepts_single_item_array
    Squares.new(%w(1))
  end

  def test_create_accepts_multiple_items_array
    Squares.new(%w(1 2 3 4 5))
  end
end
