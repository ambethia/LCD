var TABLE = [119, 36, 93, 109, 46, 107, 123, 37, 127, 111];
var H_SYM = "-";
var V_SYM = "|";
var S_SYM = " ";

var LCD = function(input, segments) {
  var numbers = [];
  input.split("").forEach(function(c, i) {
    numbers[i] = parseInt(c);
  });
  this.numbers = numbers;
  this.segments = segments;
}

LCD.prototype.test = function(number, position) {
  return (TABLE[number] & Math.pow(2, position)) > 0;
};

LCD.prototype.draw = function() {
  var offset = 0;
  for (var row = 0; row < 5; row++) {
    if (row % 2 == 0) {
      var self = this;
      this.numbers.forEach(function(number) {
        var symbol = self.test(number, row + offset) ? H_SYM : S_SYM;
        var symbols = "";
        for (var i = 0; i < self.segments; i++) {
          symbols += symbol;
        };
        process.stdout.write(S_SYM + symbols + S_SYM + S_SYM);
      });
      process.stdout.write("\n");
    } else {
      for (var i = 0; i < this.segments; i++) {
        var self = this;
        this.numbers.forEach(function(number) {
          for (var column = 0; column < 2; column++) {
            var symbol = self.test(number, row + column + offset) ? V_SYM : S_SYM;
            var spaces = "";
            for (var i = 0; i < (column == 0 ? self.segments : 1); i++) {
              spaces += S_SYM;
            };
            process.stdout.write(symbol + spaces);
          };
        });
        process.stdout.write("\n");
      };
      offset++;
    };
  };
};

var args = process.argv.slice(2)

if (args.length > 0) {
  var input;
  var segments = 2;
  if (args[0] == "-s") {
    segments = args[1];
    input = args[2];
  } else {
    input = args[0];
  };
  var lcd = new LCD(input, segments);
  lcd.draw();
} else {
  console.log("Usage: node lcd.js [-s SEGMENTS] NUMBER")
};
