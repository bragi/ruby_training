#!/usr/bin/env ruby

class RomanNumbers
  def initialize(args)
    number = args.first
  end
  
  def convert!
    
    # TODO: Add proper implementation

    exit(0) # Finish gracefully by default, change if appropriate
  end
end

#Make sure RomanNumbers#convert! ends the program with exit()
RomanNumbers.new(ARGV).convert! unless ARGV.empty?

require 'test/unit'

class StringTest < Test::Unit::TestCase
  def test_check_valid_arabic
    assert_true "1".valid_arabic?
    assert_true "1234567890".valid_arabic?
    assert_true "44".valid_arabic?
  end
  
  def test_check_invalid_arabic
    assert_false "aa".valid_arabic?
    assert_false "123,34".valid_arabic?
    assert_false "MMX".valid_arabic?
  end

  def test_check_valid_roman
    assert_true "I".valid_roman?
    assert_true "IX".valid_roman?
    assert_true "VII".valid_roman?
    assert_true "IIII".valid_roman?
    assert_true "IV".valid_roman?
    assert_true "MCMXCIX".valid_roman?
    assert_true "MCCCIX".valid_roman?
    assert_true "MMXII".valid_roman?
  end
  
  def test_check_invalid_roman
    assert_false "1234".valid_arabic?
    assert_false "aaaa".valid_arabic?
    assert_false "XXC".valid_arabic?
    assert_false "MCMXCIX".valid_roman?
    assert_fasle "IIIII".valid_roman?
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
