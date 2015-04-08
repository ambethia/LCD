require "lcd/version"
require "optparse"

class LCD
  TABLE = [
    0b1110111,
    0b0100100,
    0b1011101,
    0b1101101,
    0b0101110,
    0b1101011,
    0b1111011,
    0b0100101,
    0b1111111,
    0b1101111
  ]
  H_SYM = "-"
  V_SYM = "|"
  S_SYM = " "

  attr :numbers, :segments

  def initialize(input, segments)
    @numbers = input.each_char.map(&:to_i)
    @segments = segments
  end

  def test(number, position)
    (TABLE[number] & (0b0000001 << position)) > 0
  end

  def draw
    offset = 0
    5.times do |row|
      if row.even?
        numbers.each do |number|
          symbol = test(number, row + offset) ? H_SYM : S_SYM
          print S_SYM + symbol * segments + S_SYM * 2
        end
        print "\n"
      else
        segments.times do
          numbers.each do |number|
            2.times do |column|
              symbol = test(number, row + column + offset) ? V_SYM : S_SYM
              spaces = column == 0 ? (S_SYM * segments) : S_SYM
              print symbol + spaces
            end
          end
          print "\n"
        end
        offset += 1
      end
    end
  end

  def self.main
    options = { :segments => 2 }
    parser = OptionParser.new do |o|
      o.banner = "Usage: lcd [options] NUMBER"
      o.on("-s", "--segments SEGMENTS", Integer, "The segments to print your number (default: 2)") do |s|
        options[:segments] = s
      end
    end
    parser.parse!
    if ARGV[0]
      LCD.new(ARGV[0], options[:segments]).draw
    else
      puts parser.help
    end
  end
end
