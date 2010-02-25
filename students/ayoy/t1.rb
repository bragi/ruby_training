#!/usr/bin/env ruby

$numeralValues = {
  "M" => 1000,
  "D" => 500,
  "C" => 100,
  "L" => 50,
  "X" => 10,
  "V" => 5,
  "I" => 1
}

def isRoman(number)
  if number.size > 0 && number =~ /^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/
    return true
  end
  return false
end

def toArabic(numeral)
  if !isRoman(numeral)
    print numeral, " is not a valid Roman numeral\n"
    return
  end

  symbols = numeral.split(//)
  result = 0
  lastNumber = 0

  (0...symbols.size).each do |i|
    number = $numeralValues[symbols[i]]
    if (1...number).include?(lastNumber)
      result -= 2*lastNumber
    end
    result += number
    lastNumber = number
  end

  return result
end

def toRoman(number)
  if !(1...4000).include?(number)
    print number, " is out of range\n"
    return
  end

  romanNumeral = String.new  
  digitCount = number.to_s.size
  (digitCount-1).downto(0) do |i|
    unit = 10**i
    digit = number/unit
    if digit == 9
      romanNumeral += $numeralValues.index(unit) + $numeralValues.index(10*unit)
    elsif (5..8).include?(digit)
      romanNumeral += $numeralValues.index(5*unit) +
                      $numeralValues.index(unit)*(digit-5)
    elsif digit == 4
      romanNumeral += $numeralValues.index(unit) + $numeralValues.index(5*unit)
    else
      romanNumeral += $numeralValues.index(unit) * digit
    end
    number -= digit * unit
  end
  
  return romanNumeral
end

def testIsRoman
  testSet = {
    "III"       => true,
    "MCMXXXVII" => true,
    "IXIXIXIX"  => false,
    "F"         => false,
    "DD"        => false,
    "CCLXVI"    => true,
    "MMMMM"     => false,
    "chuj"      => false,
    150         => false,
    ""          => false
  }
  puts
  puts "Testing isRoman()..."
  testSet.keys.each do |k|
    result = isRoman(k)
    print "* ", k, " => ", result, "\n"
    if result != testSet[k]
      print "failed on checking ", k, "\n"
    end
  end
end

def testToRoman
  testSet = {
    1     => "I",
    350   => "CCCL",
    2000  => "MM",
    17    => "XVII",
    768   => "DCCLXVIII",
    3888  => "MMMDCCCLXXXVIII",
    3999  => "MMMCMXCIX",
    490   => "CDXC",
    -5.87 => nil,
    0     => nil,
    "HAH" => nil
  }
  puts
  puts "Testing toRoman()..."
  testSet.keys.each do |k|
    result = toRoman(k)
    print "* ", k, " => ", result, "\n"
    if result != testSet[k]
      print "failed to convert ", k, "\n"
    end
  end
end

def testToArabic
  testSet = {
    "CCCL"            => 350,
    "MMI"             => 2001,
    "XVII"            => 17,
    "DCCLXVIII"       => 768,
    "CDXC"            => 490,
    "MMMDCCCLXXXVIII" => 3888,
    "MMMCMXCIX"       => 3999,
    "CCCCCC"          => nil,
    ""                => nil
  }
  puts
  puts "Testing toArabic()..."
  testSet.keys.sort.each do |k|
    result = toArabic(k)
    print "* ", k, " => ", result, "\n"
    if result != testSet[k]
      print "failed to convert ", k, "\n"
    end
  end
end

def doTests
  testIsRoman
  testToRoman
  testToArabic
end

def convertNumber(arg)
  number = arg.to_i
  if number < 0 || arg == "0"
    puts "Give a positive integer or a Roman number"
  elsif number == 0
    if isRoman(arg)
      puts toArabic(arg)
    else
      puts "Give a positive integer or a Roman number"
    end
  else
    puts toRoman(number)
  end
end

arg = ARGV[0]
if arg.nil?
  puts "Usage:"
  print "  ", $0, " <value>  - to convert a number between arabic and roman\n"
  print "  ", $0, " --test   - to run the testsuite\n"
  exit
else
  if arg.downcase =~ /^-{1,2}test$/
    doTests
  else
    convertNumber(arg)
  end
end

