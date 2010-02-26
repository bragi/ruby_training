#!/usr/bin/env ruby

module RomanConversion
  def valid_arabic?
    self =~ /^[0-9]+$/
  end
  
  def valid_roman?
    self =~ /^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,4})$/
  end
  
  def to_i_with_roman_conversion
    return to_i_without_roman_conversion unless valid_roman?

    numeral_values = {"M"=>1000, "D"=>500, "C"=>100, "L" => 50,
                      "X"=>10, "V" => 5, "I"=>1}

    symbols = split(//)
    result = 0
    last_number = 0

    (0...symbols.size).each do |i|
      number = numeral_values[symbols[i]]
      if (1...number).include?(last_number)
        result -= 2*last_number
      end
      result += number
      last_number = number
    end

    return result
  end
end

class Integer
  def to_roman
    arabic_number = self
    numeral_values = {"M"=>1000, "D"=>500, "C"=>100, "L" => 50,
                      "X"=>10, "V" => 5, "I"=>1}

    roman_numeral = String.new
    (to_s.size-1).downto(0) do |i|
      unit = 10**i
      digit = arabic_number/unit
      if digit == 9
        roman_numeral += numeral_values.index(unit) + numeral_values.index(10*unit)
      elsif (5..8).include?(digit)
        roman_numeral += numeral_values.index(5*unit) +
                        numeral_values.index(unit)*(digit-5)
      elsif digit == 4
        roman_numeral += numeral_values.index(unit) + numeral_values.index(5*unit)
      else
        roman_numeral += numeral_values.index(unit) * digit
      end
      arabic_number -= digit * unit
    end

    return roman_numeral
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
    if @number.valid_arabic?
      if (1..4000).include?(@number.to_i)
        puts @number.to_i.to_roman
      else
        puts "Number out of range for conversion to roman numeral"
        exit(1)
      end
    elsif @number.valid_roman?
      puts @number.to_i
    else
      puts "Give a positive integer or a roman numeral as an argument"
      exit(1)
    end

    exit(0)
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
    assert !"1234".valid_roman?
    assert !"aaaa".valid_roman?
    assert !"XXC".valid_roman?
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
