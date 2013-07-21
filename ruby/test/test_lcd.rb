require 'minitest_helper'

class TestLcd < MiniTest::Unit::TestCase

  def test_it_outputs_expected
    lcd = LCD.new("6789", 1)
    assert_equal output_6789, lcd.draw
  end

  def test_it_outputs_double_size
    lcd = LCD.new("012345", 2)
    assert_equal output_012345, lcd.draw
  end

  def output_012345
    " --        --   --        --  \n" +
    "|  |    |    |    | |  | |    \n" +
    "|  |    |    |    | |  | |    \n" +
    "           --   --   --   --  \n" +
    "|  |    | |       |    |    | \n" +
    "|  |    | |       |    |    | \n" +
    " --        --   --        --  \n"
  end
end

def output_6789
  " -   -   -   -  \n" +
  "|     | | | | | \n" +
  " -       -   -  \n" +
  "| |   | | |   | \n" +
  " -       -   -  \n"
end
