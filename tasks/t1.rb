#!/usr/bin/env ruby

module RomanConversion
  def valid_arabic?
    # TODO: implement properly
    false
  end
  
  def valid_roman?
    # TODO: implement properly
    false
  end
  
  def to_i_with_roman_conversion
    # TODO: implement properly
    to_i_without_roman_conversion
  end
end

class String
  include RomanConversion
  alias to_i_without_roman_conversion to_i
  alias to_i to_i_with_roman_conversion
end

class RomanNumerals
  def initialize(args)
    @number = args.first
  end
  
  def convert!
    # TODO: implement properly
    exit(0) # Finish gracefully by default, change if appropriate
  end
end

#Make sure RomanNumbers#convert! ends the program with exit()
RomanNumerals.new(ARGV).convert! unless ARGV.empty?

require 'test/unit'

class StringTest < Test::Unit::TestCase
  def test_check_valid_arabic
    assert "1".valid_arabic?
    assert "1234567890".valid_arabic?
    assert "44".valid_arabic?
  end
  
  def test_check_invalid_arabic
    assert !"aa".valid_arabic?
    assert !"123,34".valid_arabic?
    assert !"MMX".valid_arabic?
  end

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
    assert !"1234".valid_arabic?
    assert !"aaaa".valid_arabic?
    assert !"XXC".valid_arabic?
    assert !"MCMXCIIX".valid_roman?
    assert !"IIIII".valid_roman?
  end
  
  def test_convert_valid_arabic
    assert_equal 1234, "1234".to_i
    assert_equal 1100101, "1100101".to_i
    assert_equal 1100101, "1100101CXMMXC".to_i
  end

  def test_convert_non_number
    assert_equal 0, "abc".to_i
  end
  
  def test_convert_valid_roman
    assert_equal 1, "I".to_i
    assert_equal 9, "IX".to_i
    assert_equal 7, "VII".to_i
    assert_equal 4, "IIII".to_i
    assert_equal 4, "IV".to_i
    assert_equal 1999, "MCMXCIX".to_i
    assert_equal 1309, "MCCCIX".to_i
    assert_equal 2012, "MMXII".to_i
  end
end
