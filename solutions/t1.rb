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
    self =~ /^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,4})$/
  end
  
  def to_i_from_roman
    values = {"M" => 1000, "D" => 500, "C" => 100, "L" => 50, "X" => 10, "V" => 5, "I" => 1}
    result = 0
    last_number = 0
    
    chars.inject(0) do |result, c|
      number = values[c]
      result -= 2 * last_number if last_number < number
      result += number
      last_number = number
      result
    end
  end
end

class Integer
  def to_s_roman
    values = {1 => "I", 2 => "II", 3 => "III", 4 => "IV", 5 => "V", 6 => "VI", 7 => "VII", 8 => "VIII", 9 => "IX",
      10 => "X", 20 => "XX", 30 => "XXX", 40 => "XL", 50 => "L", 60 => "LX", 70 => "LXX", 80 => "LXXX", 90 => "XC",
      100 => "C", 200 => "CC", 300 => "CCC", 400 => "CD", 500 => "D", 600 => "DC", 700 => "DCC", 800 => "DCCC", 900 => "CM"
    }
    ones = self % 10
    tens = (self - ones) % 100
    hundreds = (self - tens - ones) % 1000
    thousands = self / 1000
    
    (["M" * thousands] + [hundreds, tens, ones].map {|v| values[v]}).compact.join
  end
end

class RomanNumerals
  def initialize(args)
    @number = args.first
  end
  
  def convert!
    puts(@number.valid_roman? ? @number.to_i_from_roman : @number.to_i.to_s_roman)
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
