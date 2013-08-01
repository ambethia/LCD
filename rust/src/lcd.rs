use std::str;

static TABLE: [uint, ..10] = [
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
];
static H_SYM: &'static str = "-";
static V_SYM: &'static str = "|";
static S_SYM: &'static str = " ";

struct LCD {
    numbers: ~[uint],
    segments: uint
}

impl LCD {

    fn new(input: ~str, segments: uint) -> LCD {
        let mut numbers = ~[];
        for input.iter().advance |c| {
            let option = std::int::from_str(str::from_char(c));
            let n : uint = match option {
                None => 0,
                Some(y) => { y }
            } as uint;
            numbers.push(n);
        }
        LCD { numbers: numbers, segments: segments }
    }

    fn test(&self, number: uint, position: int) -> bool {
        return (TABLE[number] & (0b0000001 << position)) > 0;
    }

    fn draw(&self) {
        let mut offset = 0;
        for std::int::range(0, 5) |row| {
            if (row % 2 == 0) {
                for self.numbers.iter().advance |&number| {
                    let symbol = if (self.test(number, row + offset)) { H_SYM } else { S_SYM };
                    let mut symbols = ~"";
                    for self.segments.times {
                        symbols = symbols + symbol;
                    }
                    print(S_SYM + symbols + S_SYM + S_SYM);
                }
                print("\n");
            } else {
                for self.segments.times {
                    for self.numbers.iter().advance |&number| {
                        for std::int::range(0, 2) |column| {
                            let symbol = if (self.test(number, row + column + offset)) { V_SYM } else { S_SYM };
                            let mut spaces = ~"";
                            let spaces_count = if (column == 0) { self.segments } else { 1 };
                            for spaces_count.times {
                                spaces = spaces + S_SYM;
                            }
                            print(symbol + spaces);
                        }
                    }
                    print("\n");
                }
                offset = offset + 1;
            }
        }
    }
}

fn main() {
    let args = std::os::args();
    if (args.len() > 1) {
        let mut input: ~str;
        let mut segments: uint = 2;
        if (args[1] == ~"-s") {
            match std::int::from_str(args[2]) {
                Some(n) => { segments = n as uint },
                None => {}
            };
            input = args[3];
        } else {
            input = args[1];
        }
        let lcd = LCD::new(input, segments);
        lcd.draw();
    } else {
        println("Usage: LCD [-s SEGMENTS] NUMBER");
    }
}
