class LCD {
  private static var TABLE = [119, 36, 93, 109, 46, 107, 123, 37, 127, 111];
  private static var H_SYM = "-";
  private static var V_SYM = "|";
  private static var S_SYM = " ";

  private var numbers : Array<Int>;
  private var segments : Int;

  function new(input : String, segments: Int)
  {
    var numbers = new Array<Int>();
    for (i in 0...input.length)
    {
      numbers[i] = Std.parseInt(input.charAt(i));
    }
    this.numbers = numbers;
    this.segments = segments;
  }

  function test(number : Int, position : Int) : Bool
  {
    return (TABLE[number] & Std.int(Math.pow(2, position))) > 0;
  }

  function draw()
  {
    var offset = 0;
    for (row in 0...5) {
      if (row % 2 == 0) {
        for (number in numbers) {
          var symbol = test(number, row + offset) ? H_SYM : S_SYM;
          var symbols = "";
          for (i in 0...segments) { symbols += symbol; }
          Sys.print(S_SYM + symbols + S_SYM + S_SYM);
        }
        Sys.print("\n");
      } else {
        for (i in 0...segments) {
          for (number in numbers) {
            for (column in 0...2) {
              var symbol = test(number, row + column + offset) ? V_SYM : S_SYM;
              var spaces = "";
              for (i in 0...(column == 0 ? segments : 1)) {
                spaces += S_SYM;
              }
              Sys.print(symbol + spaces);
            }
          }
          Sys.print("\n");
        }
        offset++;
      }
    }
  }

  static function main() {
    var args = Sys.args();
    if (args.length > 0) {
      var input : String;
      var segments : Int = 2;
      if (args[0] == "-s") {
        segments = Std.parseInt(args[1]);
        input = args[2];
      } else {
        input = args[0];
      }
      var lcd = new LCD(input, segments);
      lcd.draw();
    } else {
      Sys.println("Usage: LCD [-s SEGMENTS] NUMBER");
    }
  }
}
