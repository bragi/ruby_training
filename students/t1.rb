#!/usr/bin/env ruby

# Converts numbers from arabic to roman and the other way around
#
# Usage:
#    t0.rb 4
#    # prints: IV
#    t0.rb IV
#    # prints 4
#    t0.rb
#    # runs test suite

class String
  def valid_roman?
    self.match(/^[DMCXVI]+$/) && !self.match(/(?:I{5,}|IIX|CCM|XXC|VVI|DDM|IC|IM|ID|VX|VC|VM|VD)/)
  end

  def to_i_from_roman
    result = []
    self.each_char do |char|
      case char
        when "I"
          int = 1
        when "V"
          int = 5
        when "X"
          int = 10
        when "C"
          int = 100
        when "M"
          int = 1000
        when "D"
          int = 500
      end
      if result[-1] && result[-1] < int
        result[-1] = -result[-1]
      end
      result << int
    end
    result.inject {|sum, int| sum + int}
  end
end

class Integer
  def to_s_roman

  end
end

class RomanNumerals
  def initialize(args)
    @number = args.first
  end

  def convert!
    # TODO: implement
    exit(0) # Finish gracefully by default, change if appropriate
  end
end

# Make sure RomanNumbers#convert! ends the program with exit()
RomanNumerals.new(ARGV).convert! unless ARGV.empty?

require 'test/unit'

class StringTest < Test::Unit::TestCase
  def test_check_valid_roman
    assert "I".valid_roman?
    assert "IX".valid_roman?
    assert "VII".valid_roman?
    assert "IIII".valid_roman?
    assert "IV".valid_roman?
    assert "MCMXCIX".valid_roman?
    assert "MCCCIX".valid_roman?
    assert "MMXII".valid_roman?
  end

  def test_check_invalid_roman
    assert !"1234".valid_roman?
    assert !"aaaa".valid_roman?
    assert !"XXC".valid_roman?
    assert !"MCMXCIIX".valid_roman?
    assert !"IIIII".valid_roman?
  end

  def test_convert_valid_roman
    assert_equal 1, "I".to_i_from_roman
    assert_equal 9, "IX".to_i_from_roman
    assert_equal 7, "VII".to_i_from_roman
    assert_equal 4, "IIII".to_i_from_roman
    assert_equal 4, "IV".to_i_from_roman
    assert_equal 1999, "MCMXCIX".to_i_from_roman
    assert_equal 1309, "MCCCIX".to_i_from_roman
    assert_equal 2012, "MMXII".to_i_from_roman
  end
end

class IntegerTest < Test::Unit::TestCase
  def test_to_s_roman
    assert_equal "I", 1.to_s_roman
    assert_equal "IX", 9.to_s_roman
    assert_equal "VII", 7.to_s_roman
    assert_equal "IV", 4.to_s_roman
    assert_equal "MCMXCIX", 1999.to_s_roman
    assert_equal "MCCCIX", 1309.to_s_roman
    assert_equal "MMXII", 2012.to_s_roman
  end
end

