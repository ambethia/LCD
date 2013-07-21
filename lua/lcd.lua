LCD = {}
LCD.__index = LCD;

local TABLE = { 119, 36, 93, 109, 46, 107, 123, 37, 127, 111 }
local H_SYM = "-"
local V_SYM = "|"
local S_SYM = " "

function LCD.create(input, segments)
  local self = {}
  setmetatable(self, LCD);

  self.numbers = {}
  for i = 1, #input do
    self.numbers[i] = tonumber(input:sub(i,i))
  end
  self.segments = segments
  return self
end

function LCD:test(number, position)
  return bit32.band(TABLE[number + 1], 2 ^ position) > 0
end

function LCD:draw()
  local offset = 0
  for row = 0, 4 do
    if (row % 2 == 0) then
      for _, number in ipairs(self.numbers) do
        local symbol = self:test(number, row + offset) and H_SYM or S_SYM
        local symbols = ""
        for _ = 1, self.segments do
          symbols = symbols .. symbol
        end
        io.write(S_SYM .. symbols .. S_SYM .. S_SYM)
      end
      io.write('\n')
    else
      for _ = 1, self.segments do
        for _, number in ipairs(self.numbers) do
          for column = 0, 1 do
            local symbol = self:test(number, row + column + offset) and V_SYM or S_SYM
            local spaces = ""
            for _ = 1, (column == 0 and self.segments or 1) do
              spaces = spaces .. S_SYM
            end
            io.write(symbol .. spaces)
          end
        end
        io.write('\n')
      end
      offset = offset + 1
    end
  end
end

if #arg > 0 then
  local input
  local segments = 2
  if arg[1] == "-s" then
    segments = arg[2]
    input = arg[3]
  else
    input = arg[1]
  end
  local lcd = LCD.create(input, segments)
  lcd:draw()
else
  print("Usage: lua lcd.lua [-s SEGMENTS] NUMBER")
end
