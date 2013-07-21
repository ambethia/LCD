#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MAX_INPUT_LENGTH 32

const int TABLE[] = { 119, 36, 93, 109, 46, 107, 123, 37, 127, 111 };
const char H_SYM = '-';
const char V_SYM = '|';
const char S_SYM = ' ';

typedef struct {
    int numbers[MAX_INPUT_LENGTH];
    int length;
    int segments;
} LCD;

void lcd_init(LCD* lcd, char *input, int segments)
{
  lcd->length = strlen(input);
  for (int i = 0; i < lcd->length; ++i)
  {
    if (input[i] >= '0' && input[i] <= '9')
    {
        lcd->numbers[i] = input[i] - '0';
    }
  }
  lcd->segments = segments;
}

bool lcd_test(int number, int position)
{
  if (number < 10)
  {
    return (TABLE[number] & (int)(pow(2.0, position))) > 0;
  } else {
    return false;
  }
}

void lcd_draw(LCD* lcd)
{
  int offset = 0;
  for (int row = 0; row < 5; ++row)
  {
    if (row % 2 == 0)
    {
      for (int i = 0; i < lcd->length; ++i)
      {
        char symbol = lcd_test(lcd->numbers[i], row + offset) ? H_SYM : S_SYM;
        char symbols[lcd->segments];
        for (int j = 0; j < lcd->segments; ++j)
        {
          symbols[j] = symbol;
        }
        symbols[lcd->segments] = '\0';
        printf("%c%s%c%c", S_SYM, symbols, S_SYM, S_SYM);
      }
      printf("\n");
    } else {
      for (int i = 0; i < lcd->segments; ++i)
      {
        for (int j = 0; j < lcd->length; ++j)
        {
          for (int column = 0; column < 2; ++column)
          {
            char symbol = lcd_test(lcd->numbers[j], row + column + offset) ? V_SYM : S_SYM;
            int num_spaces = (column == 0 ? lcd->segments : 1);
            char spaces[num_spaces];
            for (int k = 0; k < num_spaces; ++k)
            {
              spaces[k] = S_SYM;
            }
            spaces[num_spaces] = '\0';
            printf("%c%s", symbol, spaces);
          }
        }
        printf("\n");
      }
      ++offset;
    }
  }
}

int main(int argc, char const *argv[])
{
    if (argc > 1) {
        char input[MAX_INPUT_LENGTH];
        int segments = 2;
        if (strcmp(argv[1], "-s") == 0) {
            if (argc == 4) {
                segments = atoi(argv[2]);
                strcpy(input, argv[3]);
            }
        } else {
            strcpy(input, argv[1]);
        }
        LCD *lcd = malloc(sizeof(LCD));
        lcd_init(lcd, input, segments);
        lcd_draw(lcd);
        free(lcd);
    } else {
        printf("Usage: %s [-s SEGMENTS] NUMBER\n", argv[0]);
    }
  return 0;
}
