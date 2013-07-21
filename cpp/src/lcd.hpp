#include <iostream>
#include <string>
#include <vector>
#include <cmath>

class LCD
{
  public:
    LCD(std::string input, int segments);
    ~LCD();
    void draw() const;

  private:
    static int TABLE[];
    static char H_SYM;
    static char V_SYM;
    static char S_SYM;
    bool test(int number, int position) const;
    std::vector<int> numbers;
    int segments;
};
