const TABLE = [
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

const H_SYM = '-'
const V_SYM = '|'
const S_SYM = ' '

class LCD {
  constructor (input, segments) {
    this.numbers = input.split('').map(c => parseInt(c))
    this.segments = segments
  }

  test (number, position) {
    return (TABLE[number] & (1 << position)) > 0
  }

  draw () {
    let offset = 0
    for (let row = 0; row < 5; row++) {
      if (row % 2 === 0) {
        this.numbers.forEach(number => {
          const symbol = this.test(number, row + offset) ? H_SYM : S_SYM
          process.stdout.write(S_SYM + symbol.repeat(this.segments) + S_SYM + S_SYM)
        })
        process.stdout.write('\n')
      } else {
        for (let i = 0; i < this.segments; i++) {
          this.numbers.forEach(number => {
            for (let column = 0; column < 2; column++) {
              const symbol = this.test(number, row + column + offset) ? V_SYM : S_SYM
              process.stdout.write(symbol + S_SYM.repeat(column === 0 ? this.segments : 1))
            }
          })
          process.stdout.write('\n')
        }
        offset++
      }
    }
  }
}

const args = process.argv.slice(2)

if (args.length > 0) {
  let input
  let segments = 2
  if (args[0] === '-s') {
    segments = args[1]
    input = args[2]
  } else {
    input = args[0]
  };
  const lcd = new LCD(input, segments)
  lcd.draw()
} else {
  console.log('Usage: node lcd.js [-s SEGMENTS] NUMBER')
};
