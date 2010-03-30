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


# YANEKK done in ~ 3 hours :P

class String
  ROMANS = {"I"=>1, "V"=>5, "X"=>10, "C"=>100, "D"=>500, "M"=>1000, "L"=>50}

  def valid_roman?
    self.match(/^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,4})$/) # shamelessly stealed from ayoy
  end

  def valid_arabic?
    return self.to_s =~ /^[0-9]+$/
  end

  def to_i_from_roman
    return nil unless valid_roman?
    result = []
    self.each_char do |char|
      int = String::ROMANS[char]
      result[-1] = -result[-1] if (result[-1] && result[-1] < int)
      result << int
    end
    result.inject {|sum, int| sum + int}
  end
end

class Integer
  ROMANS  = {1=>"I", 5=>"V", 10=>"X", 50 => "L", 100=>"C", 500=>"D", 1000=>"M"}

  def to_s_roman
    result = []
    base = self.to_s.reverse.chars
    base.each_with_index do |number, index|
      multiplier = ("1"+"0"*index).to_i
      number     = number.to_i
      begin

        case number
          when 1..3
            result << Integer::ROMANS[multiplier]*number
          when 4
            result << Integer::ROMANS[multiplier]+Integer::ROMANS[multiplier*5]
          when 5..8
            result << Integer::ROMANS[multiplier*5]+(Integer::ROMANS[multiplier]*(number-5))
          when 9
            result << Integer::ROMANS[multiplier]+Integer::ROMANS[multiplier*10]
        end
      rescue # occurs when it's more than 1000
        begin
          result << Integer::ROMANS[multiplier] * number
        rescue NoMethodError # occurs when it's more than 9999
          base = base.to_a
          if index >= 4 # number is more than 10000
            result << Integer::ROMANS[1000] * ((number * multiplier) / 1000)
        else            # number is less than 10000
            result << Integer::ROMANS[1000] * base[index, base.size-1].reverse.join.to_i
          end
          break
        end
      end
    end
    result.reverse.join
  end

end

class RomanNumerals
  def initialize(args)
    @number = args.first
  end

  def convert!
    if @number.valid_arabic?
      puts @number.to_i.to_s_roman
    elsif @number.valid_roman?
      puts @number.to_i_from_roman
    else
      puts "It's not a valid roman or arabic number!"
    end
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

