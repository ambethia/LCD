import 'package:args/args.dart';
import 'dart:io';
import 'dart:math';

class LCD {
  static const List<int> TABLE = const [119, 36, 93, 109, 46, 107, 123, 37, 127, 111];
  static const String H_SYM = "-";
  static const String V_SYM = "|";
  static const String S_SYM = " ";

  List<int> numbers;
  int segments;

  LCD (String input, int segments) {
    this.numbers = new List<int>();
    for (var c in input.runes) {
      numbers.add(int.parse(new String.fromCharCode(c)));
    }
    this.segments = segments;
  }

  bool test(int number, int position) {
    return (TABLE[number] & pow(2, position)) > 0;
  }

  void draw() {
    int offset = 0;
    for (int row = 0; row < 5; row++)
    {
      if (row % 2 == 0) {
        for (int number in numbers) {
           String symbol = test(number, row + offset) ? H_SYM : S_SYM;
           String symbols = "";
           for (int i = 0; i < segments; i++) {
             symbols += symbol;
           }
           stdout.write(S_SYM + symbols + S_SYM + S_SYM);
        }
        stdout.write("\n");
      } else {
        for (int i = 0; i < segments; i++) {
          for (int number in numbers) {
            for (int column = 0; column < 2; column++) {
              String symbol = test(number, row + column + offset) ? V_SYM : S_SYM;
              String spaces = "";
              for (int j = 0; j < (column == 0 ? segments : 1); j++) {
                spaces += S_SYM;
              }
              stdout.write(symbol + spaces);
            }
          }
          stdout.write("\n");
        }
        offset++;
      }
    }
  }
}

void main() {
  var parser = new ArgParser();
  parser.addOption('segments', abbr: 's', defaultsTo: '2');
  var results = parser.parse(new Options().arguments);
  if (results.rest.length > 0) {
    String input = results.rest.first;
    int segments = int.parse(results['segments']);
    LCD lcd = new LCD(input, segments);
    lcd.draw();
  } else {
    print("Usage: lcd [-s SEGMENTS] NUMBERS");
  }
}
