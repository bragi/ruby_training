#!/usr/bin/env ruby

# Simulates a simple counter, that can be incremented, decremented and reset 
# to zero.
#
# Usage:
#    t0.rb 7 increment
#    # prints 8
#    t0.rb 7 decrement
#    # prints 6
#    t0.rb 7 reset
#    # prints 0
#    t0.rb
#    # runs test suite

class Count
  
  # Creates a new Count instance with value set to value (defaults to 0)
  def initialize(value=0)
    @val = value
  end
  
  # Increments value and returns new value
  def increment
    @val = @val + 1
  end
  
  # Decrements value and returns new value
  def decrement
    @val = @val - 1
  end
  
  # Resets the value and returns new value
  def reset(value=0)
    @val = value
  end
  
  # Returns value
  def value
    @val
  end
end

class CountUI
  
  # Creates new count user interface with given command line arguments
  def initialize(arguments)
    @count = Count.new(arguments.first.to_i)
    @action = arguments.last
  end
  
  # Runs the user interface, outputs value of count after applying user 
  # selected action on it
  def run
    puts case @action
    when "increment" then @count.increment
    when "decrement" then @count.decrement
    when "reset" then @count.reset
    end
    exit(0)
  end
end

CountUI.new(ARGV).run unless ARGV.empty?

require 'test/unit'

class CountTest < Test::Unit::TestCase
  
  def test_create_without_value
    count = Count.new
    assert_equal 0, count.value
  end
  
  def test_create_with_value
    count = Count.new(7)
    assert_equal 7, count.value
  end

  def test_increment
    count = Count.new
    assert_equal 1, count.increment
  end

  def test_increment_twice
    count = Count.new
    count.increment
    assert_equal 2, count.increment
  end
  
  def test_decrement
    count = Count.new(7)
    assert_equal 6, count.decrement
  end

  def test_decrement_twice
    count = Count.new(7)
    count.decrement
    assert_equal 5, count.decrement
  end
  
  def test_reset
    count = Count.new(7)
    assert_equal 7, count.value
    count.reset
    assert_equal 0, count.value
  end

  def test_reset_with_given_value
    count = Count.new(7)
    assert_equal 7, count.value
    count.reset(3)
    assert_equal 3, count.value
  end
end
