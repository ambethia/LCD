#include "lcd.hpp"

using namespace std;

int LCD::TABLE[] = { 119, 36, 93, 109, 46, 107, 123, 37, 127, 111 };
char LCD::H_SYM = '-';
char LCD::V_SYM = '|';
char LCD::S_SYM = ' ';

LCD::LCD(std::string input, int segments): segments(segments)
{
  numbers.resize(input.length());
  for (int i = 0; i < input.length(); ++i)
  {
    char buffer[2] = { input[i], '\0' };
    numbers[i] = atoi(buffer);
  }
}

LCD::~LCD()
{
  // Nothing to do, everything is allocated on the stack.
}

bool LCD::test(int number, int position) const
{
  return (TABLE[number] & (int)pow(2.0, (double)position)) > 0;
}

void LCD::draw() const
{
  int offset = 0;
  for (int row = 0; row < 5; ++row)
  {
    if (row % 2 == 0)
    {
      std::vector<int>::const_iterator it = numbers.begin();
      for(; it != numbers.end(); ++it)
      {
        const char symbol = test(*it, row + offset) ? H_SYM : S_SYM;
        string symbols;
        for (int i = 0; i < segments; ++i)
        {
          symbols += symbol;
        }
        cout << S_SYM << symbols << S_SYM << S_SYM;
      }
      cout << endl;
    }
    else
    {
      for (int i = 0; i < segments; ++i)
      {
        std::vector<int>::const_iterator it = numbers.begin();
        for(; it != numbers.end(); ++it) {
          for (int column = 0; column < 2; ++column)
          {
            const char symbol = test(*it, row + column + offset) ? V_SYM : S_SYM;
            string spaces;
            for (int i = 0; i < (column == 0 ? segments : 1); ++i)
            {
              spaces += S_SYM;
            }
            cout << symbol << spaces;
          }
        }
        cout << endl;
      }
      ++offset;
    }
  }
}

int main(int argc, char const *argv[])
{
  if (argc > 1)
  {
    string input;
    int segments = 2;
    if (strcmp(argv[1], "-s") == 0)
    {
      if (argc == 4)
      {
        segments = atoi(argv[2]);
        input = string(argv[3]);
      }
    }
    else
    {
      input = string(argv[1]);
    }
    const LCD lcd (input, segments);
    lcd.draw();
  }
  else
  {
    cout << "Usage: lcd [-s SEGMENTS] NUMBER";
  }
  return 0;
}
